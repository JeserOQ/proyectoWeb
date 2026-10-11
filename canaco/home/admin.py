from django.contrib import admin
from .models import Categoria, Archivo, Perfil, Publicacion, GaleriaPublicacion, Comentario

# Registro de modelos en el panel de administración
@admin.register(Categoria)
class CategoriaAdmin(admin.ModelAdmin):
    list_display = ('id', 'nombre', 'createdat', 'fk_user')
    search_fields = ('nombre',)

@admin.register(Archivo)
class ArchivoAdmin(admin.ModelAdmin):
    list_display = ('id', 'nombre', 'ruta', 'tipo', 'tamano', 'createdat')
    search_fields = ('nombre',)

@admin.register(Perfil)
class PerfilAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'apellido_paterno', 'apellido_materno')
    search_fields = ('user__username', 'apellido_paterno', 'apellido_materno')

class GaleriaInline(admin.TabularInline):
    model = GaleriaPublicacion
    extra = 1

@admin.register(Publicacion)
class PublicacionAdmin(admin.ModelAdmin):
    list_display = ('id', 'titulo', 'categoria', 'autor', 'estado', 'visitas', 'createdat')
    list_filter = ('estado', 'categoria')
    search_fields = ('titulo', 'resumen', 'contenido')
    inlines = [GaleriaInline]

@admin.register(Comentario)
class ComentarioAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'publicacion', 'estado', 'createdat')
    list_filter = ('estado',)
    search_fields = ('contenido', 'user__username', 'publicacion__titulo')
