from django.shortcuts import render

from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.conf import settings
from django.core.mail import EmailMessage
from django.utils import timezone
from django.urls import reverse
from .models import *

@login_required
def Home(request):
    return render(request, 'index.html')

def RegisterView(request):

    if request.method == "POST":
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        username = request.POST.get('username')
        password = request.POST.get('password')

        user_data_has_error = False

        # make sure email and username are not being used
        if User.objects.filter(username=username).exists():
            user_data_has_error = True
            messages.error(request, "username already exists")
        
        # nshe password is 10 characters long
        if len(password) < 8:
            user_data_has_error = True
            messages.error(request="password must be at least 8 characters")
        
        if user_data_has_error:
            return redirect('register.html')
        else:
            new_user = User.objects.create_user(
                first_name=first_name,
                last_name=last_name,
                username=username,
                password=password
            )
            messages.success(request, 'Account created. Login now')
            return redirect('login')
        

    return render(request, 'register.html')

def LoginView(request):

    if request.method == "POST":
        username = request.POST.get("username")
        email = request.POST.get("email")
        password = request.POST.get("password")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request,user)

            return redirect('home')
        else:
            messages.error(request="Invalid login credentials")
            return redirect('login')

    return render(request, 'login.html')

def LogoutView(request):

    logout(request)

    return redirect('login')


@login_required
def RegisterExamView(request):
    if request.method == 'POST':
        exam_id = request.POST.get('exam_id')
        student = request.user  # The logged-in student

        # Check if the selected exam exists
        try:
            exam = Exam.objects.get(id=exam_id)
        except Exam.DoesNotExist:
            messages.error(request, "Exam not found.")
            return redirect('home')  # or 'student_dashboard' if you create one

        # Check if the exam is full
        if ExamRegistration.objects.filter(exam=exam).count() >= exam.capacity:
            messages.error(request, "This exam is full.")
            return redirect('home')

        # Check if the student already registered for this exam
        if ExamRegistration.objects.filter(student=student, exam=exam).exists():
            messages.error(request, "You already registered for this exam.")
            return redirect('home')

        # Check if student has already registered for 3 exams
        if ExamRegistration.objects.filter(student=student).count() >= 3:
            messages.error(request, "You cannot register for more than 3 exams.")
            return redirect('home')

        # Register the student
        ExamRegistration.objects.create(student=student, exam=exam)
        messages.success(request, "Successfully registered for the exam!")
        return redirect('home')

    else:
        exams = Exam.objects.all()
        return render(request, 'register_exam.html', {'exams': exams})

@login_required
def StudentDashboardView(request):
    student = request.user
    registrations = ExamRegistration.objects.filter(student=student)

    return render(request, 'student_dashboard.html', {'registrations': registrations})

@login_required
def CancelRegistrationView(request, registration_id):
    student = request.user

    try:
        registration = ExamRegistration.objects.get(id=registration_id, student=student)
    except ExamRegistration.DoesNotExist:
        messages.error(request, "Registration not found.")
        return redirect('student_dashboard')

    registration.delete()
    messages.success(request, "Registration cancelled successfully.")
    return redirect('student_dashboard')
