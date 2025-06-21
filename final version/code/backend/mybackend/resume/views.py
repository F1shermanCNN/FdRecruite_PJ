from django.shortcuts import render

# Create your views here.

from rest_framework import viewsets
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAuthenticatedOrReadOnly

from django.db.models import Q
from requests import request

from resume.models import *
from .serializers import *

from .permissions import *

from rest_framework.exceptions import PermissionDenied




# 简单对象 ViewSets
class LanguageViewSet(viewsets.ModelViewSet):
    queryset = Language.objects.all()
    serializer_class = LanguageSerializer
    permission_classes = [AllowAny]

class IndustryViewSet(viewsets.ModelViewSet):
    queryset = Industry.objects.all()
    serializer_class = IndustrySerializer
    permission_classes = [AllowAny]

class CityViewSet(viewsets.ModelViewSet):
    queryset = City.objects.all()
    serializer_class = CitySerializer
    permission_classes = [AllowAny]

class SchoolViewSet(viewsets.ModelViewSet):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer
    permission_classes = [AllowAny]

class JobTitleViewSet(viewsets.ModelViewSet):
    queryset = JobTitle.objects.all()
    serializer_class = JobTitleSerializer
    permission_classes = [AllowAny]

class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = [AllowAny]


# 主要业务对象 ViewSets
class JobSeekerViewSet(viewsets.ModelViewSet):
    queryset = JobSeeker.objects.all()
    serializer_class = JobSeekerSerializer
    permission_classes = [IsOwnerOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        keyword = self.request.query_params.get("keyword", "").strip()
        education = self.request.query_params.get('education')
        city = self.request.query_params.get('city')
        job_title = self.request.query_params.get('job_title')
        industry = self.request.query_params.get('industry')

        if keyword:
            queryset = queryset.filter(
            Q(user__username__icontains=keyword) |
            Q(desiredjobtitle__job_title__name__icontains=keyword) |
            Q(desiredcity__city__name__icontains=keyword) |
            Q(desiredindustry__industry__name__icontains=keyword) |
            Q(educationexperience__school__name__icontains=keyword) |
            Q(jobseekerlanguage__language__name__icontains=keyword)
            ).distinct()
        
        if education:
            queryset = queryset.filter(education=education)

        if city:
            queryset = queryset.filter(desiredcity__city__name=city)

        if job_title:
            queryset = queryset.filter(desiredjobtitle__job_title__name=job_title)

        if industry:
            queryset = queryset.filter(desiredindustry__industry__name=industry)

        return queryset
    
    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return JobSeekerCreateSerializer
        return JobSeekerSerializer
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class CompanyViewSet(viewsets.ModelViewSet):
    serializer_class = CompanySerializer
    permission_classes = [IsOwnerOrReadOnly]
    queryset = Company.objects.all()

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return CompanyCreateSerializer
        return CompanySerializer
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class PositionViewSet(viewsets.ModelViewSet):
    queryset = Position.objects.all()
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        keyword = self.request.query_params.get("keyword", "").strip()
        city = self.request.query_params.get("city")
        job_title = self.request.query_params.get("job_title")
        industry = self.request.query_params.get("industry")
        education = self.request.query_params.get("education")
        experience = self.request.query_params.get("experience")

        if keyword:
            queryset = queryset.filter(
                Q(job_title__name__icontains=keyword) |
                Q(company__user__username__icontains=keyword) |
                Q(description__icontains=keyword) |
                Q(industry__name__icontains=keyword) |
                Q(city__name__icontains=keyword) |
                Q(positionlanguagerequirement__language__name__icontains=keyword)
            ).distinct()

        if city:
            queryset = queryset.filter(city__name=city)

        if job_title:
            queryset = queryset.filter(job_title__name=job_title)

        if industry:
            queryset = queryset.filter(industry__name=industry)

        if education:
            queryset = queryset.filter(education_required=education)

        if experience:
            queryset = queryset.filter(experience_required=experience)

        return queryset
    
    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return PositionCreateSerializer
        return PositionSerializer
    
    def perform_create(self, serializer):
        company = serializer.validated_data['company']
        if company.user != self.request.user:
            raise PermissionDenied("You can only post positions for your own company.")
        serializer.save()

    def perform_update(self, serializer):
        company = serializer.validated_data.get('company', serializer.instance.company)
        if company.user != self.request.user:
            raise PermissionDenied("You can only edit positions of your own company.")
        serializer.save()

    def perform_destroy(self, instance):
        company = instance.company
        if company.user != self.request.user:
            raise PermissionDenied("You can only delete positions of your own company.")
        instance.delete()



class CompanyLocationViewSet(viewsets.ModelViewSet):
    queryset = CompanyLocation.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return CompanyLocationCreateSerializer
        return CompanyLocationSerializer

    def perform_create(self, serializer):
        company = serializer.validated_data['company']
        if company.user != self.request.user:
            raise PermissionDenied("You can only add locations for your own company.")
        serializer.save()

    def perform_update(self, serializer):
        company = serializer.validated_data.get('company', serializer.instance.company)
        if company.user != self.request.user:
            raise PermissionDenied("You can only update locations for your own company.")
        serializer.save()

    def perform_destroy(self, instance):
        if instance.company.user != self.request.user:
            raise PermissionDenied("You can only delete locations of your own company.")
        instance.delete()

class CompanyTagViewSet(viewsets.ModelViewSet):
    queryset = CompanyTag.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return CompanyTagCreateSerializer
        return CompanyTagSerializer
    
    def perform_create(self, serializer):
        company = serializer.validated_data['company']
        if company.user != self.request.user:
            raise PermissionDenied("You can only add tags for your own company.")
        serializer.save()

    def perform_update(self, serializer):
        company = serializer.validated_data.get('company', serializer.instance.company)
        if company.user != self.request.user:
            raise PermissionDenied("You can only update tags for your own company.")
        serializer.save()

    def perform_destroy(self, instance):
        if instance.company.user != self.request.user:
            raise PermissionDenied("You can only delete tags of your own company.")
        instance.delete()


class PositionLanguageRequirementViewSet(viewsets.ModelViewSet):
    queryset = PositionLanguageRequirement.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return PositionLanguageRequirementCreateSerializer
        return PositionLanguageRequirementSerializer

    def perform_create(self, serializer):
        position = serializer.validated_data['position']
        if position.company.user != self.request.user:
            raise PermissionDenied("You can only add language requirements to your own positions.")
        serializer.save()

    def perform_update(self, serializer):
        position = serializer.validated_data.get('position', serializer.instance.position)
        if position.company.user != self.request.user:
            raise PermissionDenied("You can only update language requirements of your own positions.")
        serializer.save()

    def perform_destroy(self, instance):
        if instance.position.company.user != self.request.user:
            raise PermissionDenied("You can only delete language requirements of your own positions.")
        instance.delete()


class JobSeekerOwnerPermissionMixin:
    def check_jobseeker_ownership(self, jobseeker):
        if jobseeker.user != self.request.user:
            raise PermissionDenied("You can only operate on your own JobSeeker data.")

    def perform_create(self, serializer):
        jobseeker = serializer.validated_data['job_seeker']
        self.check_jobseeker_ownership(jobseeker)
        serializer.save()

    def perform_update(self, serializer):
        jobseeker = serializer.validated_data.get('job_seeker', serializer.instance.job_seeker)
        self.check_jobseeker_ownership(jobseeker)
        serializer.save()

    def perform_destroy(self, instance):
        self.check_jobseeker_ownership(instance.job_seeker)
        instance.delete()


class DesiredIndustryViewSet(JobSeekerOwnerPermissionMixin, viewsets.ModelViewSet):
    queryset = DesiredIndustry.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return DesiredIndustryCreateSerializer
        return DesiredIndustrySerializer


class DesiredJobTitleViewSet(JobSeekerOwnerPermissionMixin, viewsets.ModelViewSet):
    queryset = DesiredJobTitle.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return DesiredJobTitleCreateSerializer
        return DesiredJobTitleSerializer


class DesiredCityViewSet(JobSeekerOwnerPermissionMixin, viewsets.ModelViewSet):
    queryset = DesiredCity.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return DesiredCityCreateSerializer
        return DesiredCitySerializer


class EducationExperienceViewSet(JobSeekerOwnerPermissionMixin, viewsets.ModelViewSet):
    queryset = EducationExperience.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return EducationExperienceCreateSerializer
        return EducationExperienceSerializer


class JobSeekerLanguageViewSet(JobSeekerOwnerPermissionMixin, viewsets.ModelViewSet):
    queryset = JobSeekerLanguage.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return JobSeekerLanguageCreateSerializer
        return JobSeekerLanguageSerializer

class FavoritePositionViewSet(viewsets.ModelViewSet):
    queryset = FavoritePosition.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return FavoritePositionCreateSerializer
        return FavoritePositionSerializer

    def perform_create(self, serializer):
        job_seeker = serializer.validated_data.get('job_seeker')
        if job_seeker.user != self.request.user:
            raise PermissionDenied("You can only create favorites for your own JobSeeker.")
        serializer.save()

    def perform_update(self, serializer):
        job_seeker = serializer.validated_data.get('job_seeker', serializer.instance.job_seeker)
        if job_seeker.user != self.request.user:
            raise PermissionDenied("You can only update favorites for your own JobSeeker.")
        serializer.save()

    def perform_destroy(self, instance):
        if instance.job_seeker.user != self.request.user:
            raise PermissionDenied("You can only delete your own favorites.")
        instance.delete()


# CompanyFavoriteJobSeekerViewSet：公司收藏求职者
class CompanyFavoriteJobSeekerViewSet(viewsets.ModelViewSet):
    queryset = CompanyFavoriteJobSeeker.objects.all()
    permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return CompanyFavoriteJobSeekerCreateSerializer
        return CompanyFavoriteJobSeekerSerializer

    def perform_create(self, serializer):
        company = serializer.validated_data.get('company')
        if company.user != self.request.user:
            raise PermissionDenied("You can only create favorites for your own company.")
        serializer.save()

    def perform_update(self, serializer):
        company = serializer.validated_data.get('company', serializer.instance.company)
        if company.user != self.request.user:
            raise PermissionDenied("You can only update favorites for your own company.")
        serializer.save()

    def perform_destroy(self, instance):
        if instance.company.user != self.request.user:
            raise PermissionDenied("You can only delete your company's favorites.")
        instance.delete()