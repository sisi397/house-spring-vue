import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";

import Bookmark from "@/views/Bookmark.vue";

import Member from "@/views/Member.vue";
import MemberJoin from "@/components/user/MemberJoin.vue";
import MemberLogin from "@/components/user/MemberLogin.vue";
import MemberInfo from "@/components/user/MemberInfo.vue";
import MemberModify from "@/components/user/MemberModify.vue";

import Board from "@/views/Board.vue";
import BoardList from "@/components/board/BoardList.vue";
import BoardWrite from "@/components/board/BoardWrite.vue";
import BoardView from "@/components/board/BoardView.vue";
import BoardUpdate from "@/components/board/BoardUpdate.vue";
import BoardDelete from "@/components/board/BoardDelete.vue";

import House from "@/views/House.vue";
import kakaoMap from "@/views/Map.vue";
import news from "@/views/News.vue";

Vue.use(VueRouter);

const requireAuth = () => (to, from, next) =>{
  console.log(sessionStorage.getItem("access-token"))
  if(sessionStorage.getItem("access-token") == null){
    return next('/user/signin');
  }
  next()
}

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/user",
    name: "Member",
    component: Member,
    children: [
      {
        path: "signin",
        name: "SignIn",
        component: MemberLogin,
      },
      {
        path: "signup",
        name: "SignUp",
        component: MemberJoin,
      },
      {
        path: "memberInfo",
        name: "MemberInfo",
        component: MemberInfo,
      },
      {
        path: "memberModify",
        name: "MemberModify",
        component: MemberModify,
      },
    ],
  },
  {
    path: "/bookmark",
    name: "Bookmark",
    component: Bookmark,
    beforeEnter: requireAuth()
  },
  {
    path: "/board",
    name: "Board",
    component: Board,
    redirect: "/board/list",
    children: [
      {
        path: "list",
        name: "BoardList",
        component: BoardList,
      },
      {
        path: "write",
        name: "BoardWrite",
        component: BoardWrite,
      },
      {
        path: "detail/:articleno",
        name: "BoardView",
        component: BoardView,
      },
      {
        path: "update/:articleno",
        name: "BoardUpdate",
        component: BoardUpdate,
      },
      {
        path: "delete/:articleno",
        name: "BoardDelete",
        component: BoardDelete,
      },
    ],
  },
  {
    path: "/about",
    name: "About",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
  {
    path: "/house",
    name: "House",
    component: House,
    beforeEnter: requireAuth()
  },
  {
    path: "/map",
    name: "Map",
    component: kakaoMap,
    beforeEnter: requireAuth()
  },
  {
    path:"/news",
    name: "News",
    component: news,
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
