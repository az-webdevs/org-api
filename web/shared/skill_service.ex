defmodule Org.SkillService do
  import Ecto.Query
  alias Org.{Repo, User, Language}

  def create_user_skills(user) do
    languages = Repo.all(from l in Language)
    user
    |> Repo.preload(:languages)
    |> User.changeset(%{})
    |> Ecto.Changeset.put_assoc(:languages, languages)
  end
end
