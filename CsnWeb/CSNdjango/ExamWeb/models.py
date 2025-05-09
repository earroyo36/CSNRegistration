from django.contrib.auth.models import AbstractUser
from django.db import models

# Custom user model
class CustomUser(AbstractUser):
    ROLE_CHOICES = (
        ('student', 'Student'),
        ('faculty', 'Faculty'),
    )
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='student')

# Exam model
class Exam(models.Model):
    exam_name = models.CharField(max_length=100)
    exam_date = models.DateField()
    exam_time = models.TimeField()
    capacity = models.IntegerField(default=20)
    
    def __str__(self):
        return f"{self.exam_name} on {self.exam_date} at {self.exam_time}"

# Exam Registration model
class ExamRegistration(models.Model):
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE)
    registration_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.student.username} - {self.exam.exam_name}"
    
class Location(models.Model):
    campus_name = models.CharField(max_length=100)
    building_number = models.CharField(max_length=10)
    room_number = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.campus_name} - Bldg {self.building_number}, Room {self.room_number}"
