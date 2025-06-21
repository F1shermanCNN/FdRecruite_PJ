import { createRouter, createWebHistory } from 'vue-router'
import JobSeekerList from '../views/JobSeekerList.vue'
import JobSeekerDetail from '../views/JobSeekerDetail.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import Company_Home from '../views/Company_Home.vue'
import Company_Info from '../views/Company_Info.vue'
import PositionDetail from '../views/PositionDetail.vue'
import Jobseeker_Home from '../views/Jobseeker_Home.vue'
import Jobseeker_Info from '../views/Jobseeker_Info.vue'
import JobList from '../views/JobList.vue'
import CompanyPositionCreate from '../views/CompanyPositionCreate.vue'
import Favourite_JobSeekers from '../views/Favourite_JobSeekers.vue'
import Company_Info_update from '../views/Company_Info_update.vue'
import Position_update from '../views/Position_update.vue'
import Favourite_Positions from '../views/Favourite_Positions.vue'
import { login } from '../api/api'
import Jobseeker_update_basic from '../views/Jobseeker_update_basic.vue'
import PositionDetail_jobseeker from '../views/PositionDetail_jobseeker.vue'
import Create_Jobseeker from '../views/Create_Jobseeker.vue'
import Favourite_Match from '../views/Favourite_Match.vue'
import AI_Match from '../views/AI_Match.vue'
import Reaction from '../views/Reaction.vue'
import Jobseeker_update_background from '../views/Jobseeker_update_background.vue'
import Jobseeker_update_experience from '../views/Jobseeker_update_experience.vue'
import Jobseeker_update_city from '../views/Jobseeker_update_city.vue'
import Jobseeker_update_education from '../views/Jobseeker_update_education.vue'
import Jobseeker_update_industry from '../views/Jobseeker_update_industry.vue'
import Jobseeker_update_jobtitle from '../views/Jobseeker_update_jobtitle.vue'
import Jobseeker_update_language from '../views/Jobseeker_update_language.vue'



const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/reaction',
    name: 'reaction',
    component: Reaction
  },
  {
    path: '/company_home/jobseekers/:id',
    name: 'JobSeekerList',
    component: JobSeekerList
  },
  {
    //新加的  查看收藏夹内的职Jobseeker信息
    path: '/company_home/company_info/favourite_jobseekers/:id/:id',
    name: 'CompanyFavouriteJobSeekerDetail',
    component: JobSeekerDetail
  },
  {
    path: '/company_home/jobseekers/:id/:id',
    name: 'JobSeekerDetail',
    component: JobSeekerDetail
  },
  {
    //新加的  登录界面
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    //新加的  注册界面
    path: '/register',
    name: 'register',
    component: Register
  },
  {
    //新加的  注册界面
    path: '/register/createjobseeker/:password/:username',
    name: 'createjobseeker',
    component: Create_Jobseeker
  },
  {
    //新加的  企业主页
    path: '/company_home/:id',
    name: 'company_home',
    component: Company_Home
  },
  {
    //新加的  企业信息
    path: '/company_home/company_info/:id',
    name: 'company_info',
    component: Company_Info
  },
  
  {
    //新加的  企业信息
    path: '/company_home/company_info/:id/update',
    name: 'company_info_update',
    component: Company_Info_update
  },
  {
    //新加的  查看收藏夹
    path: '/company_home/company_info/favourite_jobseekers/:id',
    name: 'favourite_jobseekers',
    component: Favourite_JobSeekers
  },
  
  {
    //新加的  新增岗位
    path: '/company_home/company_info/create_position/:id',
    name: 'create_position',
    component: CompanyPositionCreate
  },
  {
    //新加的  岗位信息
    path: '/company_home/company_info/:id/:id',
    name: 'positiondetail',
    component: PositionDetail
  },
  {
    //新加的  企业查看岗位信息查看收藏夹
    path: '/company_home/company_info/favourite/:id/:id',
    name: 'matchfavourite',
    component: Favourite_Match
  },
  {
    //新加的  企业查看岗位信息查看收藏夹内职位
    path: '/company_home/company_info/favourite/:id/:id/:id',
    name: 'match',
    component: AI_Match
  },
  {
    //新加的  岗位修改
    path: '/company_home/company_info/update/:id/:id',
    name: 'position_update',
    component: Position_update
  },
  {
    //新加的  求职者主页
    path: '/jobseeker_home/:id',
    name: 'jobseeker_home',
    component: Jobseeker_Home
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/:id',
    name: 'jobseeker_info',
    component: Jobseeker_Info
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_basic/:id',
    name: 'jobseeker_info_update',
    component: Jobseeker_update_basic
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_background/:id',
    name: 'jobseeker_info_update_background',
    component: Jobseeker_update_background
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_experience/:id',
    name: 'jobseeker_info_update_experience',
    component: Jobseeker_update_experience
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_city/:id',
    name: 'jobseeker_info_update_city',
    component: Jobseeker_update_city
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_education/:id',
    name: 'jobseeker_info_update_education',
    component: Jobseeker_update_education
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_industry/:id',
    name: 'jobseeker_info_update_industry',
    component: Jobseeker_update_industry
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_jobtitle/:id',
    name: 'jobseeker_info_update_jobtitle',
    component: Jobseeker_update_jobtitle
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/jobseeker_info/update_language/:id',
    name: 'jobseeker_info_update_language',
    component: Jobseeker_update_language
  },
  {
    //新加的  求职者收藏夹
    path: '/jobseeker_home/jobseeker_info/favourite_positions/:id',
    name: 'favourite_positions',
    component: Favourite_Positions
  },
  {
    //新加的  求职者收藏的职位信息
    path: '/jobseeker_home/jobseeker_info/favourite_positions/:id/:id',
    name: 'favourite_positions——detial',
    component: PositionDetail_jobseeker
  },
  {
    //新加的  求职者信息
    path: '/jobseeker_home/joblist/:id',
    name: 'joblist',
    component: JobList
  },
  {
    //新加的  岗位信息
    path: '/jobseeker_home/joblist/:id/:id',
    name: 'jonseeker_view_positiondetail',
    component: PositionDetail_jobseeker
  },
  

]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
