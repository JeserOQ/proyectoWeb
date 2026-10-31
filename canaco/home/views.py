import os
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth import logout, update_session_auth_hash
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.models import User
from django.core.files.storage import default_storage
from django.db.models import F
from .models import Archivo, Categoria, Comentario, GaleriaPublicacion, Perfil, Publicacion
from functools import wraps
from django.contrib.auth.views import redirect_to_login

def es_operador(user):
    return user.is_authenticated and user.is_staff and user.is_active

def operador_required(view_func):
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect_to_login(request.get_full_path(), 'home:login')
        if not es_operador(request.user):
            messages.error(request, 'No tienes permiso para acceder a esa página.')
            return redirect('home:perfil')
        return view_func(request, *args, **kwargs)
    return wrapper

#Guarda la foto del usuario
def guardar_archivo(upload, user):
    filename = default_storage.save(f"uploads/{upload.name}", upload)
    return Archivo.objects.create(
        nombre=upload.name,
        nombre_temporal=filename,
        ruta=filename,
        tipo=upload.content_type,
        tamano=upload.size,
        fk_user=user,
    )


# Vistas Generales / Públicas
def index(request):
    publicaciones = Publicacion.objects.filter(
        estado=Publicacion.ESTADO_PUBLICADO,
    ).select_related('categoria', 'autor__perfil__foto_perfil', 'imagen_portada').order_by('-createdat')
    recientes = list(publicaciones[:5])
    return render(request, 'home/index.html', {
        'slider': publicaciones[:3],
        'principal': recientes[0] if recientes else None,
        'columna_a': recientes[1:3],
        'columna_b': recientes[3:5],
        'mas_vistas': publicaciones.order_by('-visitas')[:3],
    })

def contactanos(request):
    return render(request, 'home/contactanos.html')

def categoria(request, pk=None):
    categorias = Categoria.objects.all().order_by('nombre')
    categoria_actual = get_object_or_404(Categoria, pk=pk) if pk else None
    publicaciones = Publicacion.objects.filter(
        estado=Publicacion.ESTADO_PUBLICADO,
    ).select_related('categoria', 'autor', 'imagen_portada')
    if categoria_actual:
        publicaciones = publicaciones.filter(categoria=categoria_actual)
    return render(request, 'home/categoria.html', {
        'categorias': categorias,
        'categoria_actual': categoria_actual,
        'publicaciones': publicaciones.order_by('-createdat'),
    })

def noticia(request, pk=None):
    if pk and es_operador(request.user):
        qs = Publicacion.objects.all()
    else:
        qs = Publicacion.objects.filter(estado=Publicacion.ESTADO_PUBLICADO)

    qs = qs.select_related('categoria', 'autor', 'imagen_portada')
    if pk:
        publicacion = get_object_or_404(qs, pk=pk)
    else:
        publicacion = qs.order_by('-createdat').first()

    if not publicacion:
        messages.info(request, 'Todavía no hay noticias publicadas.')
        return redirect('home:index')

    cookie_name = f'noticia_vista_{publicacion.pk}'
    ya_vista = request.COOKIES.get(cookie_name)
    debe_marcar_cookie = False

    if not ya_vista:
        Publicacion.objects.filter(pk=publicacion.pk).update(visitas=F('visitas') + 1)
        publicacion.refresh_from_db()
        debe_marcar_cookie = True

    if request.method == 'POST':
        if not request.user.is_authenticated:
            messages.error(request, 'Debes iniciar sesión para comentar.')
            return redirect('home:login')
        contenido = request.POST.get('contenido', '').strip()
        if contenido:
            Comentario.objects.create(
                publicacion=publicacion,
                user=request.user,
                contenido=contenido,
            )
            messages.success(request, 'Comentario enviado. Será visible cuando lo apruebe el administrador.')
        return redirect('home:noticia_detalle', pk=publicacion.pk)

    recientes = Publicacion.objects.filter(
        estado=Publicacion.ESTADO_PUBLICADO,
    ).exclude(pk=publicacion.pk).order_by('-createdat')[:4]
    comentarios = publicacion.comentarios.filter(
        estado=Comentario.ESTADO_APROBADO,
    ).select_related('user').order_by('-createdat')
    categorias = Categoria.objects.all().order_by('nombre')

    response = render(request, 'home/noticia.html', {
        'publicacion': publicacion,
        'recientes': recientes,
        'comentarios': comentarios,
        'categorias': categorias,
    })

    if debe_marcar_cookie:
        response.set_cookie(cookie_name, '1', max_age=31536000, httponly=True, samesite='Lax')

    return response

@login_required
def perfil(request):
    perfil_usuario, _ = Perfil.objects.get_or_create(user=request.user)
    return render(request, 'home/perfil.html', {'perfil_usuario': perfil_usuario})

def sign_up(request):
    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        email = request.POST.get('email', '').strip()
        first_name = request.POST.get('first_name', '').strip()
        apellido_paterno = request.POST.get('apellido_paterno', '').strip()
        apellido_materno = request.POST.get('apellido_materno', '').strip()
        password1 = request.POST.get('password1', '')
        password2 = request.POST.get('password2', '')

        if password1 != password2:
            messages.error(request, 'Las contraseñas no coinciden.')
            return redirect('home:sign_up')

        if User.objects.filter(username=username).exists():
            messages.error(request, 'El nombre de usuario ya está en uso.')
            return redirect('home:sign_up')

        if User.objects.filter(email=email).exists():
            messages.error(request, 'El correo electrónico ya está registrado.')
            return redirect('home:sign_up')

        user = User.objects.create_user(username=username, email=email, password=password1)
        user.first_name = first_name
        user.last_name = ' '.join(filter(None, [apellido_paterno, apellido_materno]))
        user.save()
        perfil, _ = Perfil.objects.get_or_create(user=user)
        perfil.apellido_paterno = apellido_paterno
        perfil.apellido_materno = apellido_materno
        perfil.save()
        messages.success(request, 'Tu cuenta ha sido creada con éxito. Ahora puedes iniciar sesión.')
        return redirect('home:login')

    return render(request, 'home/sign_up.html')


@operador_required
def crear_publicacion(request):
    categorias = Categoria.objects.all().order_by('nombre')
    if request.method == 'POST':
        portada = request.FILES.get('imagen_portada')
        if not portada:
            messages.error(request, 'La imagen de portada es obligatoria.')
            return render(request, 'home/crear_publicacion.html', {'categorias': categorias})

        publicacion = Publicacion.objects.create(
            titulo=request.POST.get('titulo', '').strip(),
            resumen=request.POST.get('resumen', '').strip(),
            contenido=request.POST.get('contenido', '').strip(),
            categoria_id=request.POST.get('categoria') or None,
            estado=request.POST.get('estado') or Publicacion.ESTADO_BORRADOR,
            autor=request.user,
            imagen_portada=guardar_archivo(portada, request.user),
        )
        for imagen in request.FILES.getlist('galeria'):
            GaleriaPublicacion.objects.create(
                publicacion=publicacion,
                archivo=guardar_archivo(imagen, request.user),
            )
        messages.success(request, 'Publicación creada correctamente.')
        return redirect('home:crud_noticias')
    return render(request, 'home/crear_publicacion.html', {'categorias': categorias})

@operador_required
def crear_usuario(request):
    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        email = request.POST.get('email', '').strip()
        first_name = request.POST.get('first_name', '').strip()
        apellido_paterno = request.POST.get('apellido_paterno', '').strip()
        apellido_materno = request.POST.get('apellido_materno', '').strip()
        password1 = request.POST.get('password1', '')
        password2 = request.POST.get('password2', '')

        if not username or not password1:
            messages.error(request, 'Usuario y contraseña son obligatorios.')
            return redirect('home:crear_usuario')
        if password1 != password2:
            messages.error(request, 'Las contraseñas no coinciden.')
            return redirect('home:crear_usuario')
        if User.objects.filter(username=username).exists():
            messages.error(request, 'El usuario ya existe.')
            return redirect('home:crear_usuario')

        user = User.objects.create_user(username=username, email=email, password=password1)
        user.first_name = first_name
        user.last_name = ' '.join(filter(None, [apellido_paterno, apellido_materno]))
        rol = request.POST.get('rol')
        user.is_staff = rol in ['editor', 'administrador']
        user.is_superuser = rol == 'administrador'
        user.save()
        perfil, _ = Perfil.objects.get_or_create(user=user)
        perfil.apellido_paterno = apellido_paterno
        perfil.apellido_materno = apellido_materno
        perfil.save()
        messages.success(request, 'Usuario creado correctamente.')
        return redirect('home:crud_usuarios')

    return render(request, 'home/crear_usuario.html')


def cerrar_sesion_view(request):
    return redirect('home:login.html') # Redirige a la vista de inicio de sesión


# Vistas de Panel Administrador / CRUD
@login_required
def crud_cambiar_contrasena(request):
    if request.method == 'POST':
        actual = request.POST.get('actual')
        nueva = request.POST.get('nueva')
        confirmar = request.POST.get('confirmar')

        user = request.user

        if not user.check_password(actual):
            messages.error(request, 'La contraseña actual es incorrecta.')
            return redirect('home:crud_cambiar_contrasena')

        if nueva != confirmar:
            messages.error(request, 'Las nuevas contraseñas no coinciden.')
            return redirect('home:crud_cambiar_contrasena')

        user.set_password(nueva)
        user.save()
        update_session_auth_hash(request, user)

        messages.success(request, 'Contraseña actualizada correctamente.')
        return redirect('home:crud_cambiar_contrasena')

    return render(request, 'home/crud_cambiar_contrasena.html')


@operador_required
def crud_categorias(request):
    if request.method == 'POST':
        nombre = request.POST.get('nombre', '').strip()
        if nombre:
            Categoria.objects.create(nombre=nombre, fk_user=request.user)
            messages.success(request, 'Categoría agregada correctamente.')
            return redirect('home:crud_categorias')
    categorias = Categoria.objects.all().order_by('-createdat')
    return render(request, 'home/crud_categorias.html', {'categorias': categorias})

@operador_required
def crud_comentarios(request):
    comentarios = Comentario.objects.select_related('publicacion', 'user').order_by('-createdat')
    return render(request, 'home/crud_comentarios.html', {'comentarios': comentarios})

@operador_required
def aprobar_comentario(request, pk):
    comentario = get_object_or_404(Comentario, pk=pk)
    comentario.estado = Comentario.ESTADO_APROBADO
    comentario.save()
    return redirect('home:crud_comentarios')

@operador_required
def bloquear_comentario(request, pk):
    comentario = get_object_or_404(Comentario, pk=pk)
    comentario.estado = Comentario.ESTADO_BLOQUEADO
    comentario.save()
    return redirect('home:crud_comentarios')

@operador_required
def eliminar_comentario(request, pk):
    comentario = get_object_or_404(Comentario, pk=pk)
    if request.method == 'POST':
        comentario.delete()
    return redirect('home:crud_comentarios')

@operador_required
def crud_noticias(request):
    publicaciones = Publicacion.objects.select_related('categoria', 'autor').order_by('-createdat')
    return render(request, 'home/crud_noticias.html', {'publicaciones': publicaciones})

@operador_required
def editar_publicacion(request, pk):
    publicacion = get_object_or_404(Publicacion, pk=pk)
    categorias = Categoria.objects.all().order_by('nombre')
    if request.method == 'POST':
        publicacion.titulo = request.POST.get('titulo', '').strip()
        publicacion.resumen = request.POST.get('resumen', '').strip()
        publicacion.contenido = request.POST.get('contenido', '').strip()
        publicacion.categoria_id = request.POST.get('categoria') or None
        publicacion.estado = request.POST.get('estado') or Publicacion.ESTADO_BORRADOR
        portada = request.FILES.get('imagen_portada')
        if portada:
            publicacion.imagen_portada = guardar_archivo(portada, request.user)
        elif not publicacion.imagen_portada:
            messages.error(request, 'La imagen de portada es obligatoria.')
            return render(request, 'home/crear_publicacion.html', {
                'categorias': categorias,
                'publicacion': publicacion,
            })
        publicacion.save()
        for imagen in request.FILES.getlist('galeria'):
            GaleriaPublicacion.objects.create(
                publicacion=publicacion,
                archivo=guardar_archivo(imagen, request.user),
            )
        messages.success(request, 'Publicación actualizada correctamente.')
        return redirect('home:crud_noticias')
    return render(request, 'home/crear_publicacion.html', {
        'categorias': categorias,
        'publicacion': publicacion,
    })

@operador_required
def publicar_publicacion(request, pk):
    publicacion = get_object_or_404(Publicacion, pk=pk)
    if publicacion.estado != Publicacion.ESTADO_PUBLICADO:
        publicacion.estado = Publicacion.ESTADO_PUBLICADO
    else:
        publicacion.estado = Publicacion.ESTADO_BORRADOR
    publicacion.save()
    return redirect('home:crud_noticias')

@operador_required
def eliminar_publicacion(request, pk):
    publicacion = get_object_or_404(Publicacion, pk=pk)
    if request.method == 'POST':
        publicacion.delete()
        messages.success(request, 'Publicación eliminada correctamente.')
    return redirect('home:crud_noticias')

@login_required
def crud_perfil(request):
    user = request.user
    perfil, _ = Perfil.objects.get_or_create(user=user)

    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        email = request.POST.get('email', '').strip()
        first_name = request.POST.get('first_name', '').strip()
        apellido_paterno = request.POST.get('apellido_paterno', '').strip()
        apellido_materno = request.POST.get('apellido_materno', '').strip()
        foto = request.FILES.get('foto')

        if not username:
            messages.error(request, 'El usuario es obligatorio.')
            return redirect('home:crud_perfil')
        if User.objects.filter(username=username).exclude(pk=user.pk).exists():
            messages.error(request, 'Ese nombre de usuario ya está en uso.')
            return redirect('home:crud_perfil')

        user.username = username
        if email:
            user.email = email
            user.first_name = first_name
            user.last_name = ' '.join(filter(None, [apellido_paterno, apellido_materno]))
            user.save()

        perfil.apellido_paterno = apellido_paterno
        perfil.apellido_materno = apellido_materno

        if foto:
            if perfil.foto_perfil:
                archivo_anterior = perfil.foto_perfil
                if archivo_anterior.ruta and hasattr(archivo_anterior.ruta, 'path') and os.path.exists(archivo_anterior.ruta.path):
                    os.remove(archivo_anterior.ruta.path)
                archivo_anterior.delete()

            perfil.foto_perfil = guardar_archivo(foto, user)

        perfil.save()

        messages.success(request, 'Perfil actualizado correctamente.')
        return redirect('home:perfil')

    return render(request, 'home/crud_perfil.html', {'perfil_usuario': perfil})


@operador_required
def crud_usuarios(request):
    for usuario in User.objects.all():
        Perfil.objects.get_or_create(user=usuario)
    usuarios = User.objects.select_related('perfil').order_by('date_joined')
    return render(request, 'home/crud_usuarios.html', {'usuarios': usuarios})


@operador_required
def editar_categoria(request, pk):
    categoria = get_object_or_404(Categoria, pk=pk)
    if request.method == 'POST':
        nombre = request.POST.get('nombre', '').strip()
        if nombre:
            categoria.nombre = nombre
            categoria.save()
            messages.success(request, 'Categoría actualizada correctamente.')
        return redirect('home:crud_categorias')
    return render(request, 'home/editar_categoria.html', {'categoria': categoria})


@operador_required
def eliminar_categoria(request, pk):
    categoria = get_object_or_404(Categoria, pk=pk)
    if request.method == 'POST':
        categoria.delete()
        messages.success(request, 'Categoría eliminada correctamente.')
    return redirect('home:crud_categorias')

@operador_required
def editar_usuario(request, pk):
    usuario = get_object_or_404(User, pk=pk)
    perfil, _ = Perfil.objects.get_or_create(user=usuario)
    if request.method == 'POST':
        usuario.username = request.POST.get('username', usuario.username).strip()
        usuario.email = request.POST.get('email', usuario.email).strip()
        usuario.first_name = request.POST.get('first_name', usuario.first_name).strip()
        perfil.apellido_paterno = request.POST.get('apellido_paterno', perfil.apellido_paterno).strip()
        perfil.apellido_materno = request.POST.get('apellido_materno', perfil.apellido_materno).strip()
        usuario.last_name = ' '.join(filter(None, [perfil.apellido_paterno, perfil.apellido_materno]))
        rol = request.POST.get('rol')
        if rol:
            usuario.is_staff = rol in ['editor', 'administrador']
            usuario.is_superuser = rol == 'administrador'
        password1 = request.POST.get('password1', '')
        password2 = request.POST.get('password2', '')
        if password1 or password2:
            if password1 != password2:
                messages.error(request, 'Las contraseñas no coinciden.')
                return redirect('home:editar_usuario', pk=usuario.pk)
            usuario.set_password(password1)
        usuario.save()
        perfil.save()
        messages.success(request, 'Usuario actualizado correctamente.')
        return redirect('home:crud_usuarios')
    return render(request, 'home/crear_usuario.html', {
        'usuario_editado': usuario,
        'perfil_editado': perfil,
    })


@operador_required
def bloquear_usuario(request, pk):
    usuario = get_object_or_404(User, pk=pk)
    if usuario != request.user:
        usuario.is_active = not usuario.is_active
        usuario.save()
    return redirect('home:crud_usuarios')


@operador_required
def eliminar_usuario(request, pk):
    usuario = get_object_or_404(User, pk=pk)
    if request.method == 'POST' and usuario != request.user:
        usuario.delete()
    return redirect('home:crud_usuarios')