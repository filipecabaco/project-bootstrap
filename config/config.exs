import Mix.Config

config :###project_name_lower_case###,
  ecto_repos: [###project_name###.Persistency.Main],
  base_url: System.get_env("BASE_URL", "http://localhost:4001")

config :###project_name_lower_case###, ###project_name###.Persistency.Main,
  url: System.get_env("DATABASE_URL", "postgresql://postgres:postgres@localhost/###project_name_lower_case###"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: !!System.get_env("DATABASE_SSL")

config :###project_name_lower_case###, Redix, url: System.get_env("REDIS_URL", "redis://localhost:6379")

config :###project_name_lower_case###, ###project_name###.Web.Session.Manager,
  issuer: "###project_name_lower_case###",
  secret_key: System.get_env("USER_SESSION_SECRET")

config :###project_name_lower_case###, Plug.Session,
  secret_key_base: System.get_env("USER_SESSION_SECRET"),
  signing_salt: System.get_env("USER_SESSION_SALT")


config :###project_name_lower_case###, ###project_name###.Email,
  client:
    (if(Mix.env() == :prod) do
       ###project_name###.Email.Sendgrid
     end)

config :###project_name_lower_case###, ###project_name###.Email.Sendgrid, api_key: System.get_env("SENDGRID_API_KEY")
