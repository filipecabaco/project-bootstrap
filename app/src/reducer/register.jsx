export const registerReducer = (state, action) => {
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
    case "register": {
      return {
        ...state,
        loading: true,
        error: null,
        registered: null
      }
    }
    case "success": {
      return {
        ...state,
        loading: false,
        registered: "Success! Please verify your email",
        email: null,
        password: null,
      }
    }
    case "invalid_email": {
      return {
        ...state,
        error: "It seems that the email provided is invalid, please check again",
        loading: false,
      }
    }
    case "email_taken": {
      return {
        ...state,
        error: "It seems that the email already has an account.",
        loading: false,
      }
    }
    case "error": {
      return {
        ...state,
        error: "Seems there was a problem creating your account",
        loading: false,
      }
    }
    default:
      return state
  }
}

export const registerInitialState = {
  email: null,
  loading: false,
  error: null,
  registered: null,
}
