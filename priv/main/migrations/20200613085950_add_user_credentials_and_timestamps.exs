defmodule ###project_name###.Persistency.Main.Migrations.AddUserCredentialsAndTimestamps do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :password, :text, null: false
    end
  end
end
