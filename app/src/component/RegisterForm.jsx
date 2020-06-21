import * as React from "react";
import { Fragment, useContext, useEffect } from "react";

import Button from "@material-ui/core/Button";
import TextField from "@material-ui/core/TextField";

import { UserContext } from "../container/App";
import Toast from "../component/Toast"
import { register } from "../service/register";

const RegisterForm = () => {
  const { registerState, registerDispatch } = useContext(UserContext)
  const { email, password, loading, error, registered } = registerState;
  const onSubmit = (e) => {
    e.preventDefault()
    registerDispatch({ type: "register" })
  }

  useEffect(() => {
    if (loading) {
      register(
        email,
        password,
        () => registerDispatch({ type: "success" }),
        ({ opcode }) => {
          console.log(opcode)
          switch (opcode) {
            case "00002":
              registerDispatch({ type: "invalid_email" })
              break
            case "00003":
              registerDispatch({ type: "email_taken" })
              break
            default: registerDispatch({ type: "error" })
          }
        })
    }
  }, [loading])

  return <Fragment>
    <form method="POST" onSubmit={onSubmit}>
      <TextField type="text" placeholder="Email" name="email" onChange={(e) => registerDispatch({ type: "email", payload: e.target.value })} required={true} />
      <TextField type="password" placeholder="Password" name="password" onChange={(e) => registerDispatch({ type: "password", payload: e.target.value })} required={true} />
      <Button type="register">register</Button>
    </form>
    <Toast cond={registered} severity={"success"} msg={registered} />
    <Toast cond={error} severity={"warning"} msg={error} />
  </Fragment>

}

export default RegisterForm