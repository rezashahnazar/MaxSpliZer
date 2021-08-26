import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import HowTo from '../views/HowTo.vue'
import Docs from '../views/Docs.vue'
import ContactUs from '../views/ContactUs.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/howto',
    name: 'HowTo',
    component: HowTo
  },
  {
    path: '/docs',
    name: 'Docs',
    component: Docs
  },
  {
    path: '/contactus',
    name: 'ContactUs',
    component: ContactUs
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
