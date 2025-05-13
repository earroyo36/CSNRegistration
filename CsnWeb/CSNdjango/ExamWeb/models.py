from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings

# Custom user model
class CustomUser(AbstractUser):
    ROLE_CHOICES = (
        ('student', 'Student'),
        ('faculty', 'Faculty'),
    )
    role = models.CharField(max_length=10, choices=ROLE_CHOICES)

    
class Location(models.Model):
    campus_name = models.CharField(max_length=100)
    building_number = models.CharField(max_length=10)
    room_number = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.campus_name} - Bldg {self.building_number}, Room {self.room_number}"

# Exam model
class Exam(models.Model):
    exam_name = models.CharField(max_length=100)
    exam_date = models.DateField()
    exam_time = models.TimeField()
    capacity = models.IntegerField(default=20)
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    proctor = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, limit_choices_to={'role': 'faculty'})

    def __str__(self):
        return f"{self.exam_name} on {self.exam_date} at {self.exam_time}"

# Exam Registration model
class ExamRegistration(models.Model):
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE, related_name='registrations')
    registration_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.student.username} - {self.exam.exam_name}"
    
