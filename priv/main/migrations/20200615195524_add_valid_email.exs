defmodule ###project_name###.Persistency.Main.Migrations.AddValidEmail do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :valid_email, :boolean, null: false, default: false
    end
  end
end
