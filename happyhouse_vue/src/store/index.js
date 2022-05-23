import Vue from "vue";
import Vuex from "vuex";
import http from "@/api/http";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    sidos: [{ value: null, text: "선택하세요" }],
    guguns: [{ value: null, text: "선택하세요" }],
    dongs: [{ value: null, text: "선택하세요" }],
    houses: [],
    house: null,
    subway: [],
    todos: [
      // { title: '할 일1', completed: false },
      // { title: '할 일2', completed: false },
    ],
    observesidos: [],
    observegudongs: [],
    loginUser: {
      id: null,
      pw: null,
      email: null,
      age: null,
      name: null,
      grade: null,
      time: null,
    },
  },
  getters: {
    loginUser(state) {
      return state.loginUser;
    },
    allTodosCount(state) {
      return state.todos.length;
    },
    completedTodosCount(state) {
      return state.todos.filter((todo) => {
        return todo.completed === true;
      }).length;
    },
    unCompletedTodosCount(state) {
      return state.todos.filter((todo) => {
        return todo.completed === false;
      }).length;
    },
    allObserveSidos(state) {
      return state.observesidos;
    },
    allObserveGuDongs(state) {
      return state.observegudongs;
    },
    checkhouse(state) {
      return state.houses;
    },
    allsubway(state) {
      return state.subway;
    },
  },
  mutations: {
    //////////////////////  회원 관련 기능  //////////////////////
    SET_USER_DATA(state, userdata) {
      console.log("SET_USER_DATA : ", userdata);
      state.loginUser = userdata;
    },
    CLEAR_USER_DATA(state) {
      state.loginUser = {};
    },
    //////////////////////   observe start   //////////////////////
    SET_OBSV_SIDO_LIST(state, sidos) {
      state.observesidos = sidos;
    },
    SET_OBSV_GUDONG_LIST(state, gudongs) {
      state.observegudongs = gudongs;
    },
    /////////////////////////////// House start /////////////////////////////////////
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      });
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach((gugun) => {
        state.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
      });
    },
    SET_DONG_LIST(state, dongs) {
      dongs.forEach((dong) => {
        state.dongs.push({ value: dong.dongCode, text: dong.dongName });
      });
    },
    SET_SUBWAY_LIST(state, subways) {
      state.subway = subways;
    },
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: "선택하세요" }];
    },
    SET_HOUSE_LIST(state, houses) {
      state.houses = houses;
    },
    SET_DETAIL_HOUSE(state, house) {
      console.log("Mutations", house);
      state.house = house;
    },
    /////////////////////////////// House end /////////////////////////////////////

    //////////////////////////// Todo List start //////////////////////////////////
    CREATE_TODO(state, todoItem) {
      state.todos.push(todoItem);
    },
    DELETE_TODO(state, todoItem) {
      const index = state.todos.indexOf(todoItem);
      state.todos.splice(index, 1);
    },
    UPDATE_TODO_STATUS(state, todoItem) {
      state.todos = state.todos.map((todo) => {
        if (todo === todoItem) {
          return {
            ...todo,
            completed: !todoItem.completed,
          };
        }
        return todo;
      });
    },
    //////////////////////////// Todo List end //////////////////////////////////
  },
  actions: {
    //////////////////////   User start   //////////////////////
    loginSuccess({ commit }, userInfo) {
      console.log("loginSuccess : ", userInfo);
      commit("SET_USER_DATA", userInfo);
    },
    logout({ commit }) {
      console.log("logout");
      commit("CLEAR_USER_DATA");
    },
    //////////////////////   observe start   //////////////////////
    getObserveSidos({ commit }) {
      http
        .get(`observe/sido`)
        .then(({ data }) => {
          commit("SET_OBSV_SIDO_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },

    getObserveGuDongs({ commit }, Sido) {
      console.log(Sido);
      http
        .get(`observe/gudong/${Sido}`)
        .then(({ data }) => {
          commit("SET_OBSV_GUDONG_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    /////////////////////////////// House start /////////////////////////////////////
    getSido({ commit }) {
      http
        .get(`/Building/Si`)
        .then(({ data }) => {
          // console.log(data);
          commit("SET_SIDO_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getGugun({ commit }, sidoCode) {
      const params = { sido: sidoCode };
      http
        .get(`/Building/Gu`, { params })
        .then(({ data }) => {
          // console.log(commit, response);
          commit("SET_GUGUN_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getDong({ commit }, gugunCode) {
      const params = { gugun: gugunCode };
      http
        .get(`/Building/Dong`, { params })
        .then(({ data }) => {
          commit("SET_DONG_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getHouseList({ commit }, dongCode) {
      const params = { dong: dongCode };
      http
        .get(`/Building/House`, { params })
        .then(({ data }) => {
          commit("SET_HOUSE_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getSubwayList({ commit }) {
      http
        .get(`/Building/Subway`)
        .then(({ data }) => {
          commit("SET_SUBWAY_LIST", data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    detailHouse({ commit }, house) {
      // 나중에 house.일련번호를 이용하여 API 호출
      // console.log(commit, house);
      commit("SET_DETAIL_HOUSE", house);
    },
    /////////////////////////////// House end /////////////////////////////////////

    //////////////////////////// Todo List start //////////////////////////////////

    // destructuring 활용
    createTodo({ commit }, todoItem) {
      commit("CREATE_TODO", todoItem);
    },
    actionDeleteTodo({ commit }, todoItem) {
      commit("DELETE_TODO", todoItem);
    },
    actionUpdateTodoStatus({ commit }, todoItem) {
      commit("UPDATE_TODO_STATUS", todoItem);
    },
    //////////////////////////// Todo List end //////////////////////////////////
  },
  plugins: [
    createPersistedState({
      // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
      storage: sessionStorage,
    }),
  ],
});
