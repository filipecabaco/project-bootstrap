defmodule ###project_name###.Persistency.Main.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :external_id, :uuid, null: false
      add :email, :string, null: false
      timestamps()
    end
    create unique_index(:user, [:external_id])
    create unique_index(:user, [:email])
  end
end
