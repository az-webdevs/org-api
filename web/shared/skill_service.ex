defmodule Org.SkillService do
  alias Org.{Repo, Skill, User, Language}

  def create_user_skills(user) do
    language = Repo.get(Language, 1)
    user
    |> Repo.preload(:languages)
    |> User.changeset(%{})
    |> Ecto.Changeset.put_assoc(:languages, [language])
  end
end
