from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.LoginAPIView.as_view()),
    path('register/', view=views.RegisterAPIView.as_view())
]
