from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer, UserSerializer
from .models import User
from rest_framework import serializers

class CustomUserCreateSerializer(BaseUserCreateSerializer):
    class Meta(BaseUserCreateSerializer.Meta):
        model = User
        fields = ('id', 'username', 'email', 'password', 'user_type')

class CustomUserSerializer(UserSerializer):
    username = serializers.CharField(required=True)
    class Meta(UserSerializer.Meta):
        model = User
        fields = ('id', 'username', 'email', 'user_type')