import { get, post } from "axios"
export function isLogged(success, error) {
  get("/login")
    .then(success)
    .catch((e) => error(e.response.data))
}

export function login(email, password, success, error) {
  post("/login", { email, password })
    .then(success)
    .catch((e) => error(e.response.data))
}
