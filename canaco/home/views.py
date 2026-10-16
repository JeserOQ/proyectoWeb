from django.shortcuts import render,redirect
from django.contrib.auth import logout

# Create your views here.

# Vistas Generales / Públicas
def index(request):
    return render(request, 'home/index.html')

def contactanos(request):
    return render(request, 'home/contactanos.html')

def categoria(request):
    return render(request, 'home/categoria.html')

def login_view(request):
    return render(request, 'home/login.html')

def noticia(request):
    return render(request, 'home/noticia.html')

def perfil(request):
    return render(request, 'home/perfil.html')

def sign_up(request):
    return render(request, 'home/sign_up.html')

def crear_publicacion(request):
    return render(request, 'home/crear_publicacion.html')

def crear_usuario(request):
    return render(request, 'home/crear_usuario.html')

def cerrar_sesion_view(request):
    return redirect('home:login.html') # Redirige a la vista de inicio de sesión


# Vistas de Panel Administrador / CRUD
def crud_cambiar_contrasena(request):
    return render(request, 'home/crud_cambiar_contrasena.html')

def crud_categorias(request):
    return render(request, 'home/crud_categorias.html')

def crud_comentarios(request):
    return render(request, 'home/crud_comentarios.html')

def crud_noticias(request):
    return render(request, 'home/crud_noticias.html')

def crud_perfil(request):
    return render(request, 'home/crud_perfil.html')

def crud_usuarios(request):
    return render(request, 'home/crud_usuarios.html')

def editar_categoria(request):
    return render(request, 'home/editar_categoria.html')