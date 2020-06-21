# Project Template (delete after name change)
Project bootstrap with a Elixir app using only Plug and static serving a simple React app with Material UI.

It uses Sendgrid for the verification email and Heroku for deployment.

At the moment, React is included so it leaves more options for future actions (e.g. server-side rendering, separate project, etc) but as a quick win we static serve it from Elixir so at least we are able to move.

### Change (delete after name change)

Replace all instances of the following strings:

1. Replace all instances of the following strings:
  * ###project_name### -  Project name with camel case (e.g. PotatoFarmer)
  * ###project_name_lower_case### - lower case of project name with snake case (potato_farmer)
1. Run `mix deps.get` to fetch dependencies
1. Run `mix client.compile` to create the proper static assets.
1. Run `mix compile` to compile project
1. Run docker containers with the configuration below
1. Run `mix ecto.migrate` to create required tables
1. Run `iex -S mix` to startup

# ###project_name###

### Requirements
* `brew install elixir node`
* `docker run -d -p 6379:6379 redis:alpine`
* `docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=###project_name_lower_case### postgres:alpine`


### Set project env vars

* `BASE_URL` : Expected base url of the app (default: http://localhost:4001)
* `DATABASE_URL` : Postgres URL (default: postgresql://postgres:postgres@localhost/###project_name_lower_case###)
* `POOL_SIZE` : Number of connection to Postgres (default: 10)
* `DATABASE_SSL` : If you want SSL (default: false)
* `REDIS_URL` : Redis URL (redis://localhost:6379)
* `USER_SESSION_SECRET` : Secret used for session management key signing (default: random string that NEEDS TO BE REPLACED)
* `USER_SESSION_SALT` : Salt used to encrypt and decrypt cookies (default: random string that NEEDS TO BE REPLACED)
* `SENDGRID_API_KEY` : The Sendgrid API Key to send email validation

#### Generate Secret & Salt
`mix guardian.gen.secret` but if you want a smaller salt, in `iex` run `Base.encode64(:crypto.strong_rand_bytes(12))`

Also adviced to create a second pair of keys to set as defaults in `config.exs`for local development.

### Push new client version

* `mix client.compile` will add the new bundle to be served by the Elixir server

### Start up server

* `iex -S mix` with Repl
* `mix run --no-halt` without Repl

