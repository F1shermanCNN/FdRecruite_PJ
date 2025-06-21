from django.db import models

# Create your models here.

from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    USER_TYPE_CHOICES = (
        ('jobseeker', '求职者'),
        ('employer', '企业'),
        ('admin', '管理员'),  # 新增类型
    )

    user_type = models.CharField(max_length=20, choices=USER_TYPE_CHOICES, default='jobseeker')

    def save(self, *args, **kwargs):
        if self.is_superuser:
            self.user_type = 'admin'
        super().save(*args, **kwargs)