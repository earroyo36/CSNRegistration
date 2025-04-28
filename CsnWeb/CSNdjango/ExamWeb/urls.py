from django.urls import path
from . import views

urlpatterns =[
    
    path('', views.Home, name='home'),
    path('register/', views.RegisterView, name='register'),
    path('login/', views.LoginView, name='login'),
    path('logout/', views.LogoutView, name='logout'),

    path('register_exam/', views.RegisterExamView, name='register_exam'), 

    path('student_dashboard/', views.StudentDashboardView, name='student_dashboard'), 
    
    path('cancel_registration/<int:registration_id>/', views.CancelRegistrationView, name='cancel_registration'),


]