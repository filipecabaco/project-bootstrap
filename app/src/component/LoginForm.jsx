import * as React from "react";
import { useEffect, useContext, Fragment } from "react"
import Button from "@material-ui/core/Button";
import TextField from "@material-ui/core/TextField";

import { UserContext } from "../container/App"
import Toast from "../component/Toast"
import { login } from "../service/login";

const LoginForm = () => {
  const { loginState, loginDispatch } = useContext(UserContext)
  const { email, password, loading, error, logged } = loginState;
  const onSubmit = (e) => {
    e.preventDefault()
    loginDispatch({ type: "login" })
  }

  useEffect(() => {
    if (loading) {
      login(
        email,
        password,
        () => loginDispatch({ type: "success" }),
        () => loginDispatch({ type: "error" }))
    }
  }, [loading])

  return <Fragment>
    <form method="POST" onSubmit={onSubmit}>
      <TextField type="text" placeholder="Email" name="email" onChange={(e) => loginDispatch({ type: "email", payload: e.target.value })} required={true} />
      <TextField type="password" placeholder="Password" name="password" onChange={(e) => loginDispatch({ type: "password", payload: e.target.value })} required={true} />
      <Button type="submit">submit</Button>
    </form>
    <Toast cond={logged} severity={"success"} msg="Successfully logged in" />
    <Toast cond={error} severity={"warning"} msg={error} />
  </Fragment>

}

export default LoginForm