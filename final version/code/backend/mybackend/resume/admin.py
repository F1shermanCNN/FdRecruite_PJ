from django.contrib import admin

# Register your models here.

from django import forms
import nested_admin

from .models import *

class JobSeekerForm(forms.ModelForm):
    class Meta:
        model = JobSeeker
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['expected_min_salary'].help_text = '单位：千元/月'
        self.fields['expected_max_salary'].help_text = '单位：千元/月'

class PositionAdminForm(forms.ModelForm):
    class Meta:
        model = Position
        fields = '__all__'
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['min_salary'].help_text = '单位：千元/月'
        self.fields['max_salary'].help_text = '单位：千元/月'

class PositionInlineForm(forms.ModelForm):
    class Meta:
        model = Position
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(PositionInlineForm, self).__init__(*args, **kwargs)
        self.fields['min_salary'].help_text = "单位：千元/月"
        self.fields['max_salary'].help_text = "单位：千元/月"

class DesiredCityInline(admin.TabularInline):
    model = DesiredCity
    extra = 1
    verbose_name = "期望城市"
    verbose_name_plural = "期望城市"

class DesiredIndustryInline(admin.TabularInline):
    model = DesiredIndustry
    extra = 1
    verbose_name = "期望行业"
    verbose_name_plural = "期望行业"

class DesiredJobTitileInline(admin.TabularInline):
    model = DesiredJobTitle
    extra = 1
    verbose_name = "期望职位"
    verbose_name_plural = "期望职位"

class JobSeekerLanguageyInline(admin.TabularInline):
    model = JobSeekerLanguage
    extra = 1
    verbose_name = "语言能力"
    verbose_name_plural = "语言能力"

class EducationInline(admin.TabularInline):
    model = EducationExperience
    extra = 1
    verbose_name = "教育经历"
    verbose_name_plural = "教育经历"

class CompanyLocationInline(nested_admin.NestedTabularInline):
    model = CompanyLocation
    extra = 1
    verbose_name = "公司地址"
    verbose_name_plural = "公司地址"

class PositionLanguageRequirementInline(nested_admin.NestedTabularInline):
    model = PositionLanguageRequirement
    extra = 1

class CompanyPositionInline(nested_admin.NestedTabularInline):
    model = Position
    form = PositionInlineForm
    extra = 1
    inlines = [PositionLanguageRequirementInline]
    verbose_name = "岗位"
    verbose_name_plural = "岗位"

class CompanyTagInline(nested_admin.NestedTabularInline):
    model = CompanyTag
    extra = 1
    verbose_name = "标签"
    verbose_name_plural = "标签"


class ExpectedCityFilter(admin.SimpleListFilter):
    title = 'expected city'
    parameter_name = 'expected_city'

    def lookups(self, request, model_admin):
        cities = City.objects.filter(desiredcity__isnull=False).distinct()
        return [(city.id, f"{city.province}-{city.name}") for city in cities]

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(desiredcity__city__id=self.value())
        return queryset
    
class CompanyLocationFilter(admin.SimpleListFilter):
    title = 'city'
    parameter_name = 'company_location'

    def lookups(self, request, model_admin):
        cities = City.objects.filter(companylocation__isnull=False).distinct()
        return [(city.id, f"{city.province}-{city.name}") for city in cities]

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(companylocation__city__id=self.value())
        return queryset
    
@admin.register(JobSeeker)
class JobSeekerAdmin(admin.ModelAdmin):
    form = JobSeekerForm
    list_display = (
        'username', 'current_status', 'expected_work_type', 
        'expected_cities', 'expected_industries', 
        'expected_job_titles', 'education'
    )
    search_fields = ('user__username', 'user__email', 'phone')
    list_filter = ('expected_work_type', 'current_status', 'education', ExpectedCityFilter)
    ordering = ('-updated_at',)
    inlines = [
        DesiredCityInline, DesiredIndustryInline, 
        EducationInline, JobSeekerLanguageyInline, DesiredJobTitileInline
    ]

    @admin.display(description='Username')
    def username(self, obj):
        return obj.user.username

    @admin.display(description='Expected Cities')
    def expected_cities(self, obj):
        cities = obj.desiredcity_set.select_related('city')
        return ", ".join(f"{c.city.province}-{c.city.name}" for c in cities)

    @admin.display(description='Expected Industries')
    def expected_industries(self, obj):
        industries = Industry.objects.filter(desiredindustry__job_seeker=obj)
        return ", ".join(f"{i.name}" for i in industries)

    @admin.display(description='Expected Job Titles')
    def expected_job_titles(self, obj):
        job_titles = JobTitle.objects.filter(desiredjobtitle__job_seeker=obj)
        return ", ".join(f"{j.name}" for j in job_titles)



@admin.register(Company)
class CompanyAdmin(nested_admin.NestedModelAdmin):
    list_display = ('get_username', 'size', 'verified', 'license_period')
    search_fields = ('user__username',)
    list_filter = ('size', 'verified', CompanyLocationFilter)
    inlines = [CompanyLocationInline, CompanyPositionInline, CompanyTagInline]

    def get_username(self, obj):
        return obj.user.username if obj.user else '(无用户)'
    get_username.short_description = 'name'


@admin.register(Position)
class PositionAdmin(admin.ModelAdmin):
    form = PositionAdminForm
    list_display = ('id', 'job_title', 'company', 'city', 'min_salary_display', 'max_salary_display')
    search_fields = ('company__name', 'job_title__name')
    list_filter = ('experience_required', 'education_required', 'industry')
    inlines = [PositionLanguageRequirementInline]
    def has_add_permission(self, request): return False

    @admin.display(description='min_salary')
    def min_salary_display(self, obj):
        return f"{obj.min_salary} 千元/月"
    

    @admin.display(description='max_salary')
    def max_salary_display(self, obj):
        return f"{obj.max_salary} 千元/月"


@admin.register(Language)
class LanguageAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)


@admin.register(Industry)
class IndustryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)


@admin.register(City)
class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'province')
    list_filter = ('province',)
    search_fields = ('name',)


@admin.register(School)
class SchoolAdmin(admin.ModelAdmin):
    list_display = ('name', 'category')
    list_filter = ('category',)
    search_fields = ('name',)


@admin.register(JobTitle)
class JobTitleAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)


@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)

