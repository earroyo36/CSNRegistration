from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth.views import PasswordResetView, PasswordResetConfirmView
from .models import CustomUser, Exam, ExamRegistration

@login_required
def Home(request):
    return render(request, 'student_home.html')

# Register user
def RegisterView(request):
    if request.method == "POST":
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        password = request.POST.get('password')
        role = 'student'  # 👈 hardcode for now

       # if user is not None:
        if user.email.endswith('@student.csn.edu') or user.email.endswith('@csn.edu'):
            # register(request, user)
            pass
        else:
            messages.error(request, "Only CSN emails are allowed.")
            return redirect('register') 
        if CustomUser.objects.filter(username=email).exists():
            messages.error(request, "Email already exists.")
            return redirect('register')

        if len(password) < 8:
            messages.error(request, "Password must be at least 8 characters.")
            return redirect('register')

        user = CustomUser.objects.create_user(
            username=email,
            email=email,
            first_name=first_name,
            last_name=last_name,
            password=password,
            role=role
        )

        messages.success(request, "Account created successfully. Please log in.")
        return redirect('login')
        

    return render(request, 'register.html')


# Login user
def LoginView(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            if user.email.endswith('@student.csn.edu') or user.email.endswith('@csn.edu'):
                login(request, user)
                if user.role == 'student':
                    return redirect('student_home')
                elif user.role == 'faculty':
                    return redirect('faculty_dashboard')  # Later when faculty dashboard is built
                else:
                    messages.error(request, "Invalid user role.")
                    return redirect('login')
            else:
                messages.error(request, "Only CSN emails are allowed.")
                return redirect('login')
        else:
            messages.error(request, "Invalid login credentials.")
            return redirect('login')

    return render(request, 'login.html')

# Logout
@login_required
def LogoutView(request):
    logout(request)
    return redirect('login')

# Student home - register exams
@login_required
def StudentHomeView(request):
    exams = Exam.objects.all()
    return render(request, 'student_home.html', {'exams': exams})

# Student dashboard - see registered exams
@login_required
def StudentDashboardView(request):
    student = request.user
    registrations = ExamRegistration.objects.filter(student=student)
    return render(request, 'student_dashboard.html', {'registrations': registrations})

# Register for exam
@login_required
def RegisterExamView(request):
    if request.method == 'POST':
        exam_id = request.POST.get('exam_id')
        student = request.user

        try:
            exam = Exam.objects.get(id=exam_id)
        except Exam.DoesNotExist:
            messages.error(request, "Exam not found.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(exam=exam).count() >= exam.capacity:
            messages.error(request, "This exam is full.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(student=student, exam=exam).exists():
            messages.error(request, "You already registered for this exam.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(student=student).count() >= 3:
            messages.error(request, "You cannot register for more than 3 exams.")
            return redirect('student_home')

        ExamRegistration.objects.create(student=student, exam=exam)
        messages.success(request, "Successfully registered for the exam!")
        return redirect('student_home')

    return redirect('student_home')

# Cancel registration
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

# Password Reset View
class ForgotPasswordView(PasswordResetView):
    template_name = 'forgot_password.html'
    email_template_name = 'password_reset_email.html'
    success_url = '/password_reset_sent/'

# Password Reset Confirm View
class ResetPasswordConfirmView(PasswordResetConfirmView):
    template_name = 'reset_password.html'
    success_url = '/login/'


def password_reset_sent(request):
    return render(request, 'password_reset_sent.html')

def exam_confirmation(request):
    return render(request, 'exam_confirmation.html')

@login_required
def register_exam(request):
    if request.method == 'POST':
        exam_id = request.POST.get('exam_id')
        student = request.user

        try:
            exam = Exam.objects.get(id=exam_id)
        except Exam.DoesNotExist:
            messages.error(request, "Exam not found.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(exam=exam).count() >= exam.capacity:
            messages.error(request, "This exam is full.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(student=student, exam=exam).exists():
            messages.error(request, "You already registered for this exam.")
            return redirect('student_home')

        if ExamRegistration.objects.filter(student=student).count() >= 3:
            messages.error(request, "You cannot register for more than 3 exams.")
            return redirect('student_home')

        ExamRegistration.objects.create(student=student, exam=exam)
        messages.success(request, "Successfully registered for the exam!")
        return redirect('exam_confirmation')
    else:
        exams = Exam.objects.all()
        return render(request, 'register_exam.html', {'exams': exams})
    
@login_required
def faculty_report_view(request):
    exams = Exam.objects.all()
    locations = Location.objects.all()
    dates = Exam.objects.values_list('exam_date', flat=True).distinct()

    selected_exam = request.GET.get('exam')
    selected_date = request.GET.get('date')
    selected_campus = request.GET.get('campus')

    registrations = ExamRegistration.objects.all()

    if selected_exam:
        registrations = registrations.filter(exam__id=selected_exam)
    if selected_date:
        registrations = registrations.filter(exam__exam_date=selected_date)
    if selected_campus:
        registrations = registrations.filter(exam__location__campus_name=selected_campus)

    context = {
        'exams': exams,
        'locations': locations,
        'dates': dates,
        'registrations': registrations,
        'selected_exam': selected_exam,
        'selected_date': selected_date,
        'selected_campus': selected_campus,
    }

    return render(request, 'faculty_report.html', context)