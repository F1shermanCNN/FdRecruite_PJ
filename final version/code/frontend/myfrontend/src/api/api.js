import axios from 'axios';

const API_BASE_URL = 'http://127.0.0.1:8000/api';

const api = axios.create({
  baseURL: API_BASE_URL,
});

// 请求拦截器：自动添加 Authorization 头
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token'); // 从 localStorage 获取登录保存的 token
    if (token) {
      config.headers['Authorization'] = `Token ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// ============ 通用函数封装 ============
const create = (url, data, config = {}) => api.post(url, data, config);
const read = (url, params = {}, config = {}) => api.get(url, { params, ...config });
const update = (url, data, config = {}) => api.patch(url, data, config);
const remove = (url, config = {}) => api.delete(url, config);

// ============ 字典表（只读） ============
export const getLanguages = () => read('/languages/');
export const getIndustries = () => read('/industries/');
export const getCities = () => read('/cities/');
export const getSchools = () => read('/schools/');
export const getJobTitles = () => read('/job-titles/');
export const getTags = () => read('/tags/');

// ============ 主体对象 =============
export const getJobSeekers = (params = {}) => read('/jobseekers/', params);
export const getJobSeeker = (id) => read(`/jobseekers/${id}/`);
export const createJobSeeker = (data) => create('/jobseekers/', data);
export const updateJobSeeker = (id, data) => update(`/jobseekers/${id}/`, data);
export const deleteJobSeeker = (id) => remove(`/jobseekers/${id}/`);

export const getCompanies = () => read('/companies/');
export const getCompany = (id) => read(`/companies/${id}/`);
export const createCompany = (data) => create('/companies/', data);
export const updateCompany = (id, data) => update(`/companies/${id}/`, data);
export const deleteCompany = (id) => remove(`/companies/${id}/`);

export const getPositions = (params = {}) => read('/positions/', params);
export const getPosition = (id) => read(`/positions/${id}/`);
export const createPosition = (data) => create('/positions/', data);
export const updatePosition = (id, data) => update(`/positions/${id}/`, data);
export const deletePosition = (id) => remove(`/positions/${id}/`);

// ============ 关联表对象 ============
export const getCompanyLocations = () => read('/company-locations/');
export const getCompanyLocation = (id) => read(`/company-locations/${id}/`);
export const createCompanyLocation = (data) => create('/company-locations/', data);
export const updateCompanyLocation = (id, data) => update(`/company-locations/${id}/`, data);
export const deleteCompanyLocation = (id) => remove(`/company-locations/${id}/`);

export const getCompanyTags = () => read('/company-tags/');
export const getCompanyTag = (id) => read(`/company-tags/${id}/`);
export const createCompanyTag = (data) => create('/company-tags/', data);
export const updateCompanyTag = (id, data) => update(`/company-tags/${id}/`, data);
export const deleteCompanyTag = (id) => remove(`/company-tags/${id}/`);

export const getPositionLanguageRequirements = () => read('/position-languages/');
export const getPositionLanguageRequirement = (id) => read(`/position-languages/${id}/`);
export const createPositionLanguageRequirement = (data) => create('/position-languages/', data);
export const updatePositionLanguageRequirement = (id, data) => update(`/position-languages/${id}/`, data);
export const deletePositionLanguageRequirement = (id) => remove(`/position-languages/${id}/`);

export const getDesiredIndustries = () => read('/desired-industries/');
export const getDesiredIndustry = (id) => read(`/desired-industries/${id}/`);
export const createDesiredIndustry = (data) => create('/desired-industries/', data);
export const updateDesiredIndustry = (id, data) => update(`/desired-industries/${id}/`, data);
export const deleteDesiredIndustry = (id) => remove(`/desired-industries/${id}/`);

export const getDesiredJobTitles = () => read('/desired-job-titles/');
export const getDesiredJobTitle = (id) => read(`/desired-job-titles/${id}/`);
export const createDesiredJobTitle = (data) => create('/desired-job-titles/', data);
export const updateDesiredJobTitle = (id, data) => update(`/desired-job-titles/${id}/`, data);
export const deleteDesiredJobTitle = (id) => remove(`/desired-job-titles/${id}/`);

export const getDesiredCities = () => read('/desired-cities/');
export const getDesiredCity = (id) => read(`/desired-cities/${id}/`);
export const updateDesiredCity = (id, data) => update(`/desired-cities/${id}/`, data);
export const createDesiredCity = (data) => create('/desired-cities/', data);
export const deleteDesiredCity = (id) => remove(`/desired-cities/${id}/`);

export const getEducationExperiences = () => read('/education-experiences/');
export const createEducationExperience = (data) => create('/education-experiences/', data);
export const updateEducationExperience = (id, data) => update(`/education-experiences/${id}/`, data);
export const deleteEducationExperience = (id) => remove(`/education-experiences/${id}/`);

export const getJobSeekerLanguages = () => read('/jobseeker-languages/');
export const getJobSeekerLanguage = (id) => read(`/jobseeker-languages/${id}/`);
export const updateJobSeekerLanguage = (id, data) => update(`/jobseeker-languages/${id}/`, data);
export const createJobSeekerLanguage = (data) => create('/jobseeker-languages/', data);
export const deleteJobSeekerLanguage = (id) => remove(`/jobseeker-languages/${id}/`);

// ============ 收藏功能 ============
export const getFavoritePositions = () => read('/favorite-positions/');
export const addFavoritePosition = (data) => create('/favorite-positions/', data);
export const deleteFavoritePosition = (id) => remove(`/favorite-positions/${id}/`);

export const getCompanyFavoriteJobSeekers = () => read('/company-favorites/');
export const addCompanyFavoriteJobSeeker = (data) => create('/company-favorites/', data);
export const deleteCompanyFavoriteJobSeeker = (id) => remove(`/company-favorites/${id}/`);

// ============ 认证接口（Djoser） ============

export const register = (data) => create('/auth/users/', data);
export const login = (data) => create('/auth/token/login/', data);
export const logout = (token) =>
  create('/auth/token/logout/', {}, { headers: { Authorization: `Token ${token}` } });
export const getCurrentUser = (token) =>
  read('/auth/users/me/', {}, { headers: { Authorization: `Token ${token}` } });
export const updateCurrentUser = (data, token) =>
  update('/auth/users/me/', data, {
    headers: {
      Authorization: `Token ${token}`,
    },
  });