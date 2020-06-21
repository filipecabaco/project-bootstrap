import * as React from "react";
import LoginForm from "../component/LoginForm"
import RegisterForm from "../component/RegisterForm"
import { loginReducer, loginInitialState } from "../reducer/login"
import { registerReducer, registerInitialState } from "../reducer/register"
import { useEffect, createContext, useReducer, Fragment } from "react"
import { isLogged } from "../service/login";

export const UserContext = createContext()

const app = () => {
  const [loginState, loginDispatch] = useReducer(loginReducer, loginInitialState);
  const [registerState, registerDispatch] = useReducer(registerReducer, registerInitialState);

  const { logged } = loginState

  useEffect(() => isLogged(
    () => loginDispatch({ type: "success" }),
    () => loginDispatch({ type: "not_logged" })), [])

  return <Fragment>
    <UserContext.Provider value={{ loginState, loginDispatch, registerState, registerDispatch }}>
      <h3>###project_name###</h3>
      {logged ? null : <LoginForm />}
      {logged ? null : <RegisterForm />}
    </UserContext.Provider>
  </Fragment>
}

export default app;
