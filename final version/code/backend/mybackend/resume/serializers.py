from rest_framework import serializers
from resume.models import (
    Language, Industry, City, School, JobTitle, Tag,
    JobSeeker, Company, Position,
    FavoritePosition, DesiredIndustry, DesiredJobTitle, DesiredCity,
    EducationExperience, JobSeekerLanguage, CompanyFavoriteJobSeeker,
    CompanyLocation, PositionLanguageRequirement, CompanyTag
)

# 简单模型
class LanguageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Language
        fields = '__all__'

class IndustrySerializer(serializers.ModelSerializer):
    class Meta:
        model = Industry
        fields = '__all__'

class CitySerializer(serializers.ModelSerializer):
    class Meta:
        model = City
        fields = '__all__'

class SchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = School
        fields = '__all__'

class JobTitleSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobTitle
        fields = '__all__'

class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = '__all__'

# JobSeeker 相关嵌套序列化器
class DesiredIndustrySerializer(serializers.ModelSerializer):
    industry = IndustrySerializer()

    class Meta:
        model = DesiredIndustry
        fields = '__all__'

class DesiredIndustryCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = DesiredIndustry
        fields = '__all__'

class DesiredJobTitleSerializer(serializers.ModelSerializer):
    job_title = JobTitleSerializer()

    class Meta:
        model = DesiredJobTitle
        fields = '__all__'

class DesiredJobTitleCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = DesiredJobTitle
        fields = '__all__'

class DesiredCitySerializer(serializers.ModelSerializer):
    city = CitySerializer()

    class Meta:
        model = DesiredCity
        fields = '__all__'

class DesiredCityCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = DesiredCity
        fields = '__all__'

class JobSeekerLanguageSerializer(serializers.ModelSerializer):
    language = LanguageSerializer()

    class Meta:
        model = JobSeekerLanguage
        fields = '__all__'

class JobSeekerLanguageCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeekerLanguage
        fields = '__all__'

class EducationExperienceSerializer(serializers.ModelSerializer):
    school = SchoolSerializer()

    class Meta:
        model = EducationExperience
        fields = '__all__'

class EducationExperienceCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = EducationExperience
        fields = '__all__'

class JobSeekerSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    email = serializers.SerializerMethodField()
    id = serializers.SerializerMethodField()

    desired_industries = DesiredIndustrySerializer(source='desiredindustry_set', many=True, read_only=True)
    desired_job_titles = DesiredJobTitleSerializer(source='desiredjobtitle_set', many=True, read_only=True)
    desired_cities = DesiredCitySerializer(source='desiredcity_set', many=True, read_only=True)
    languages = JobSeekerLanguageSerializer(source='jobseekerlanguage_set', many=True, read_only=True)
    education_experiences = EducationExperienceSerializer(source='educationexperience_set', many=True, read_only=True)

    def get_name(self, obj):
        return obj.user.username

    def get_email(self, obj):
        return obj.user.email

    def get_id(self, obj):
        return obj.user.id

    class Meta:
        model = JobSeeker
        exclude = ['user']

class JobSeekerCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeeker
        exclude = ['user']


# Company 相关
class CompanyLocationSerializer(serializers.ModelSerializer):
    city = CitySerializer()

    class Meta:
        model = CompanyLocation
        fields = '__all__'

class CompanyLocationCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyLocation
        fields = '__all__'


class CompanyTagSerializer(serializers.ModelSerializer):
    tag = TagSerializer()

    class Meta:
        model = CompanyTag
        fields = '__all__'

class CompanyTagCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyTag
        fields = '__all__'

class CompanySerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    id = serializers.SerializerMethodField()
    locations = CompanyLocationSerializer(source='companylocation_set', many=True, read_only=True)
    tags = CompanyTagSerializer(source='companytag_set', many=True, read_only=True)

    def get_name(self, obj):
        return obj.user.username

    def get_id(self, obj):
        return obj.user.id

    class Meta:
        model = Company
        exclude = ['user']

class CompanyCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Company
        exclude = ['user']

# Position 相关
class PositionLanguageRequirementSerializer(serializers.ModelSerializer):
    language = LanguageSerializer()

    class Meta:
        model = PositionLanguageRequirement
        fields = '__all__'

class PositionLanguageRequirementCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = PositionLanguageRequirement
        fields = '__all__'

class PositionSerializer(serializers.ModelSerializer):
    company = CompanySerializer()
    city = CitySerializer()
    job_title = JobTitleSerializer()
    industry = IndustrySerializer()
    language_requirements = PositionLanguageRequirementSerializer(source='positionlanguagerequirement_set', many=True, read_only=True)

    class Meta:
        model = Position
        fields = '__all__'

class PositionCreateSerializer(serializers.ModelSerializer):
    company = serializers.PrimaryKeyRelatedField(queryset=Company.objects.all())
    industry = serializers.PrimaryKeyRelatedField(queryset=Industry.objects.all(), allow_null=True)
    job_title = serializers.PrimaryKeyRelatedField(queryset=JobTitle.objects.all(), allow_null=True)
    city = serializers.PrimaryKeyRelatedField(queryset=City.objects.all(), allow_null=True)

    class Meta:
        model = Position
        fields = '__all__'


# 收藏相关
class FavoritePositionSerializer(serializers.ModelSerializer):
    position = PositionSerializer()
    class Meta:
        model = FavoritePosition
        fields = '__all__'

class FavoritePositionCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = FavoritePosition
        fields = '__all__'

class CompanyFavoriteJobSeekerSerializer(serializers.ModelSerializer):
    job_seeker = JobSeekerSerializer()
    class Meta:
        model = CompanyFavoriteJobSeeker
        fields = '__all__'

class CompanyFavoriteJobSeekerCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyFavoriteJobSeeker
        fields = '__all__'
