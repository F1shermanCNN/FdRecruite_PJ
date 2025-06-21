import axios from 'axios';

const API_BASE_URL = 'http://127.0.0.1:8000/api';

const api = axios.create({
  baseURL: API_BASE_URL,
});

// ============ 通用函数封装 ============
const create = (url, data) => api.post(url, data);
const update = (url, data) => api.patch(url, data);
const remove = (url) => api.delete(url);

// ============ 字典表管理 ============

// --- Languages ---
export const createLanguage = (data) => create('/languages/', data);
export const updateLanguage = (id, data) => update(`/languages/${id}/`, data);
export const deleteLanguage = (id) => remove(`/languages/${id}/`);

// --- Industries ---
export const createIndustry = (data) => create('/industries/', data);
export const updateIndustry = (id, data) => update(`/industries/${id}/`, data);
export const deleteIndustry = (id) => remove(`/industries/${id}/`);

// --- Cities ---
export const createCity = (data) => create('/cities/', data);
export const updateCity = (id, data) => update(`/cities/${id}/`, data);
export const deleteCity = (id) => remove(`/cities/${id}/`);

// --- Schools ---
export const createSchool = (data) => create('/schools/', data);
export const updateSchool = (id, data) => update(`/schools/${id}/`, data);
export const deleteSchool = (id) => remove(`/schools/${id}/`);

// --- Job Titles ---
export const createJobTitle = (data) => create('/jobtitles/', data);
export const updateJobTitle = (id, data) => update(`/jobtitles/${id}/`, data);
export const deleteJobTitle = (id) => remove(`/jobtitles/${id}/`);

// --- Tags ---
export const createTag = (data) => create('/tags/', data);
export const updateTag = (id, data) => update(`/tags/${id}/`, data);
export const deleteTag = (id) => remove(`/tags/${id}/`);
