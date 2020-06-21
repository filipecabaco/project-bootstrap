import { post } from "axios"
export function register(email, password, success, error) {
  post("/register", { email, password })
    .then(success)
    .catch((e) => error(e.response.data))
}
