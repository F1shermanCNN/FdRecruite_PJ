from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()

# 注册基本模型
router.register(r'languages', LanguageViewSet)
router.register(r'industries', IndustryViewSet)
router.register(r'cities', CityViewSet)
router.register(r'schools', SchoolViewSet)
router.register(r'job-titles', JobTitleViewSet)
router.register(r'tags', TagViewSet)

# 注册主业务模型
router.register(r'jobseekers', JobSeekerViewSet)
router.register(r'companies', CompanyViewSet)
router.register(r'positions', PositionViewSet)

# 注册关联表
router.register(r'company-locations', CompanyLocationViewSet)
router.register(r'company-tags', CompanyTagViewSet)
router.register(r'position-languages', PositionLanguageRequirementViewSet)
router.register(r'desired-industries', DesiredIndustryViewSet)
router.register(r'desired-job-titles', DesiredJobTitleViewSet)
router.register(r'desired-cities', DesiredCityViewSet)
router.register(r'education-experiences', EducationExperienceViewSet)
router.register(r'jobseeker-languages', JobSeekerLanguageViewSet)
router.register(r'favorite-positions', FavoritePositionViewSet)
router.register(r'company-favorites', CompanyFavoriteJobSeekerViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
