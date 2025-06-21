from django.db import models

# Create your models here.

from accounts.models import User

class Language(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return f"{self.name}"

    class Meta:
        verbose_name = "语言能力"
        verbose_name_plural = "语言能力"


class Industry(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return f"{self.name}"

    class Meta:
        verbose_name = "行业"
        verbose_name_plural = "行业"


class City(models.Model):
    name = models.CharField(max_length=50)
    province = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.province} - {self.name}"

    class Meta:
        unique_together = ('name', 'province')
        verbose_name = "城市"
        verbose_name_plural = "城市"


class School(models.Model):
    CATEGORY_CHOICES = [
        ('985', '985'),
        ('211', '211'),
        ('双一流', '双一流'),
        ('普通', '普通'),
    ]
    name = models.CharField(max_length=100, unique=True)
    category = models.CharField(max_length=10, choices=CATEGORY_CHOICES, default='普通')

    def __str__(self):
        return f"{self.name}"

    class Meta:
        verbose_name = "学校"
        verbose_name_plural = "学校"


class JobTitle(models.Model):
    name = models.CharField(max_length=50, unique=True)

    class Meta:
        verbose_name = "职位"
        verbose_name_plural = "职位"

    def __str__(self):
        return f"{self.name}"


class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return f"{self.name}"

    class Meta:
        verbose_name = "标签"
        verbose_name_plural = "标签"


class JobSeeker(models.Model):
    GENDER_CHOICES = [('男', '男'), ('女', '女'), ('其他', '其他')]
    WORK_TYPE_CHOICES = [('兼职', '兼职'), ('全职', '全职'), ('实习', '实习')]
    STATUS_CHOICES = [('在职', '在职'), ('离职', '离职'), ('应届生', '应届生')]
    EDUCATION_CHOICES = [('专科', '专科'), ('本科', '本科'), ('硕士', '硕士'), ('博士', '博士')]

    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    gender = models.CharField(max_length=5, choices=GENDER_CHOICES, default='其他')
    birth_date = models.DateField()
    phone = models.CharField(max_length=11, unique=True)
    expected_work_type = models.CharField(max_length=10, choices=WORK_TYPE_CHOICES, default='全职')
    expected_min_salary = models.PositiveSmallIntegerField()
    expected_max_salary = models.PositiveSmallIntegerField()
    current_status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='离职')
    resume_pdf = models.CharField(max_length=255, blank=True, null=True)
    work_experience = models.JSONField(blank=True, null=True)
    education = models.CharField(max_length=10, choices=EDUCATION_CHOICES)
    project_experience = models.JSONField(blank=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "求职者"
        verbose_name_plural = "求职者"

    def __str__(self):
        return self.user.username


class Company(models.Model):
    SIZE_CHOICES = [('0-20人', '0-20人'), ('20-99人', '20-99人'), ('100-499人', '100-499人'), ('500+人', '500+人')]

    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    size = models.CharField(max_length=20, choices=SIZE_CHOICES, default='0-20人')
    verified = models.BooleanField(default=False)
    description = models.JSONField(blank=True, null=True)
    license_period = models.CharField(max_length=20)
    registered_capital = models.PositiveIntegerField(blank=True, null=True)

    def __str__(self):
        return f"{self.user.username}"

    class Meta:
        verbose_name = "企业"
        verbose_name_plural = "企业"


class Position(models.Model):
    EXPERIENCE_CHOICES = [('不限', '不限'), ('应届生', '应届生'), ('1-3年', '1-3年'), ('3-5年', '3-5年'), ('5年+', '5年+')]
    EDUCATION_CHOICES = [('不限', '不限'), ('专科', '专科'), ('本科', '本科'), ('硕士', '硕士'), ('博士', '博士')]

    id = models.AutoField(primary_key=True)
    min_salary = models.PositiveSmallIntegerField()
    max_salary = models.PositiveSmallIntegerField()
    min_age = models.PositiveSmallIntegerField(blank=True, null=True)
    max_age = models.PositiveSmallIntegerField(blank=True, null=True)
    experience_required = models.CharField(max_length=10, choices=EXPERIENCE_CHOICES)
    education_required = models.CharField(max_length=10, choices=EDUCATION_CHOICES)
    description = models.JSONField()
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    industry = models.ForeignKey(Industry, on_delete=models.SET_NULL, null=True, blank=True)
    job_title = models.ForeignKey(JobTitle, on_delete=models.SET_NULL, null=True, blank=True)
    city = models.ForeignKey(City, on_delete=models.RESTRICT, null=True, blank=True)

    def __str__(self):
        return f"{self.job_title}"

    class Meta:
        verbose_name = "岗位"
        verbose_name_plural = "岗位"


class FavoritePosition(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    position = models.ForeignKey(Position, on_delete=models.CASCADE)
    favorite_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('job_seeker', 'position')
        verbose_name = "求职者_收藏_岗位"
        verbose_name_plural = "求职者_收藏_岗位"



class DesiredIndustry(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    industry = models.ForeignKey(Industry, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('job_seeker', 'industry')
        verbose_name = "求职者_期望_行业"
        verbose_name_plural = "求职者_期望_行业"


class DesiredJobTitle(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    job_title = models.ForeignKey(JobTitle, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('job_seeker', 'job_title')
        verbose_name = "求职者_期望_职位"
        verbose_name_plural = "求职者_期望_职位"


class DesiredCity(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    city = models.ForeignKey(City, on_delete=models.RESTRICT)

    class Meta:
        unique_together = ('job_seeker', 'city')
        verbose_name = "求职者_期望_城市"
        verbose_name_plural = "求职者_期望_城市"


class EducationExperience(models.Model):
    DEGREE_CHOICES = [('专科', '专科'), ('学士', '学士'), ('硕士', '硕士'), ('博士', '博士'), ('MBA', 'MBA'), ('EMBA', 'EMBA')]

    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    school = models.ForeignKey(School, on_delete=models.RESTRICT)
    degree = models.CharField(max_length=10, choices=DEGREE_CHOICES)
    major = models.CharField(max_length=50)
    start_date = models.DateField()
    end_date = models.DateField()


    class Meta:
        unique_together = ('job_seeker', 'school', 'degree', 'major')
        verbose_name = "教育经历"
        verbose_name_plural = "教育经历"


class JobSeekerLanguage(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    language = models.ForeignKey(Language, on_delete=models.CASCADE)
    proficiency = models.CharField(max_length=50)

    class Meta:
        unique_together = ('job_seeker', 'language')
        verbose_name = "求职者_掌握_语言"
        verbose_name_plural = "求职者_掌握_语言"


class CompanyFavoriteJobSeeker(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    favorite_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('company', 'job_seeker')
        verbose_name = "企业用户_收藏_求职者"
        verbose_name_plural = "企业用户_收藏_求职者"


class CompanyLocation(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    city = models.ForeignKey(City, on_delete=models.RESTRICT)
    address = models.CharField(max_length=200)

    class Meta:
        unique_together = ('company', 'city')
        verbose_name = "企业_位于_城市"
        verbose_name_plural = "企业_位于_城市"


class PositionLanguageRequirement(models.Model):
    position = models.ForeignKey(Position, on_delete=models.CASCADE)
    language = models.ForeignKey(Language, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('position', 'language')
        verbose_name = "岗位_要求_语言"
        verbose_name_plural = "岗位_要求_语言"


class CompanyTag(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('company', 'tag')
        verbose_name = "企业_标签"
        verbose_name_plural = "企业_标签"
