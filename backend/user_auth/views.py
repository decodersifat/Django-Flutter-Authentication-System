from django.shortcuts import render
from django.http import HttpResponse
from .models import User
from .serializers import UserSerializer, ProfileSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from .utils.hash_pass import hashPassword, pwdValidator

class RegisterAPIView(APIView):

    permission_classes = [AllowAny]
    
    
    def post(self, request):
        user_data = request.data.get('user')
        hased_pass = hashPassword(user_data['password'])
        user_data['password'] = hased_pass
        profile_data = request.data.get('profile')

        user_serializer = UserSerializer(data=user_data)
        
        username = user_data.get('username')
        email = user_data.get('email')

        if User.objects.filter(username=username).exists():
            return Response(
                {
                    'message': 'Username already exists',
                    'key':'username'
                    },
                status=status.HTTP_400_BAD_REQUEST
            )
        if User.objects.filter(email=email).exists():
            return Response(
                {
                    'message': 'Email already exists',
                    'key':'email'
                    },
                status=status.HTTP_400_BAD_REQUEST
            )


        if user_serializer.is_valid():
            
            
            saved_user = user_serializer.save()
            profile_data['user'] = saved_user.id

            profile_serializer = ProfileSerializer(data=profile_data)
            if profile_serializer.is_valid():
                saved_profile = profile_serializer.save()
                return Response(
                    {
                        'user': UserSerializer(saved_user).data,
                        'profile': ProfileSerializer(saved_profile).data
                    },
                    status=status.HTTP_201_CREATED
                )
            else:
                saved_user.delete() 
                return Response(
                    {
                        'message': profile_serializer.errors
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )
        else:
            return Response(
                {
                    'message': user_serializer.errors
                },
                status=status.HTTP_400_BAD_REQUEST
            )
                    


class LoginAPIView(APIView):

    permission_classes = [AllowAny]
    
    def post(self, request):
        user_data = request.data.get('user')
        
        if not user_data:
            return Response({"message": "User data is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        email = user_data.get('email')
        password = user_data.get('password')

        if not email or not password:
            return Response({"message": "Username and password are required"}, status=status.HTTP_400_BAD_REQUEST)
        
        user = User.objects.filter(email=email).first()
        
        if not user:
            return Response(
                {
                    "message": "User not found"
                    }, status=status.HTTP_404_NOT_FOUND)
        
        hashedPass = user.password
        if pwdValidator(password, hashedPass):
            return Response({"message": "User authenticated"}, status=status.HTTP_200_OK)
        else:
            return Response({"message": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)
