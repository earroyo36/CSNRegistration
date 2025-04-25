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

