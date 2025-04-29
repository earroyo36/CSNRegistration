from django.urls import path
from . import views

urlpatterns =[
    

    path('', views.StudentHomeView, name='student_home'),   # landing page after login
    path('register/', views.RegisterView, name='register'),
    path('login/', views.LoginView, name='login'),
    path('logout/', views.LogoutView, name='logout'),

    path('student_home/', views.StudentHomeView, name='student_home'),
    path('student_dashboard/', views.StudentDashboardView, name='student_dashboard'),
    path('register_exam/', views.RegisterExamView, name='register_exam'),
    path('cancel_registration/<int:registration_id>/', views.CancelRegistrationView, name='cancel_registration'),

    # Password reset
    path('forgot_password/', views.ForgotPasswordView.as_view(), name='forgot_password'),
    path('password_reset_sent/', views.password_reset_sent, name='password_reset_sent'),  # simple view to render confirmation
    path('reset/<uidb64>/<token>/', views.ResetPasswordConfirmView.as_view(), name='password_reset_confirm'),

    # Exam confirmation
    path('exam_confirmation/', views.exam_confirmation, name='exam_confirmation'),

]
