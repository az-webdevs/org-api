defmodule Org.UserService do

  alias Org.{Repo, User, Language, SkillService}

  def create_or_update_solving(github_id, solves) do
    Repo.transaction fn ->
      {operation, params} = case Repo.get_by(User, github_id: github_id) do
        nil    -> {:not_found, %User{github_id: github_id}}
        params -> {:exists, params}
      end

      user = User.changeset(params)
      |> Repo.insert_or_update!

      case operation do
        :not_found ->
          Enum.each solves, fn ({key, val}) ->
            language = Language.create_or_update! key
            user
            |> SkillService.create_skills(language, val)
          end
      end

      user
    end
  end
end
