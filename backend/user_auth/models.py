from django.db import models

# Create your models here.

class User(models.Model):
    username = models.CharField(max_length = 30, blank=False, unique=True)
    email = models.EmailField(max_length = 100, blank=False, unique=True)
    password = models.CharField(max_length = 100, blank=False)
    
    def __str__(self):
        return (f"Username: {self.username}")
    
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    fname = models.CharField(max_length=50, blank=False)
    lname = models.CharField(max_length=50, blank=False)
    gender = models.CharField(max_length=50, blank=False)
    age = models.IntegerField( blank=False)
    
    def __str__(self):
        return (f"Profile of :{self.fname + + self.lname}")