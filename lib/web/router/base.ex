defmodule ###project_name###.Web.Router.Base do
  @moduledoc """
  HTTP router
  """
  use Plug.Router
  @landing File.read!("./priv/app/index.html")


  if Mix.env() == :dev do
    use Plug.Debugger
  else
    use Plug.ErrorHandler
  end

  plug(Plug.Logger)
  plug(:put_secret_key_base)
  %{signing_salt: signing_salt} = Map.new(Application.get_env(:###project_name_lower_case###, Plug.Session))
  plug(Plug.Session,
    store: :cookie,
    key: "###project_name_lower_case###",
    signing_salt: signing_salt
    )

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:match)

  get "/" do
    send_resp(conn, 200, @landing)
  end

  plug(:fetch_session)
  plug(###project_name###.Web.Session.Pipeline)
  plug(Plug.Static, at: "/", from: "priv/app")
  plug(:dispatch)

  forward("login", to: ###project_name###.Web.Router.Login)
  forward("register", to: ###project_name###.Web.Router.Register)
  forward("verify", to: ###project_name###.Web.Router.Verify)

  match _ do
    send_resp(conn, 404, "oops")
  end

  @spec redirect(Plug.Conn.t(), binary) :: Plug.Conn.t()
  def redirect(conn, url) do
    conn
    |> put_resp_header("location", url)
    |> send_resp(302, "")
  end

  def put_secret_key_base(conn, _) do
    %{secret_key_base: secret_key_base} = Map.new(Application.get_env(:###project_name_lower_case###, Plug.Session))
    put_in(conn.secret_key_base, secret_key_base)
  end

  def handle_errors(conn, _) do
    send_resp(conn, 500, "Something went wrong on our side, we'll be checking what happened")
  end
end
