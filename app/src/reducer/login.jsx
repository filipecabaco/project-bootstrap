export const loginReducer = (state, action) => {
  switch (action.type) {
    case "email": {
      return {
        ...state,
        email: action.payload
      }
    }
    case "password": {
      return {
        ...state,
        password: action.payload
      }
    }
    case "login": {
      return {
        ...state,
        loading: true,
        error: null
      }
    }
    case "success": {
      return {
        ...state,
        loading: false,
        logged: true
      }
    }
    case "not_logged":{
      return {
        ...state,
        loading: false,
        logged: false,
      }
    }
    case "error": {
      return {
        ...state,
        error: "Seems that your user or password do not match, please try again",
        loading: false,
        logged: false
      }
    }
    default:
      return state
  }
}

export const loginInitialState = {
  email: null,
  loading: false,
  error: null,
  logged: false
}
