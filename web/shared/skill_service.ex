defmodule Org.SkillService do

  alias Org.{Repo, Skill}

  def solve(user, language, solves) do
    Repo.transaction fn ->
      {operation, params} = case Repo.get_by(Skill, github_id: user.github_id) do
        nil    -> {:not_found, %Skill{github_id: github_id, language_id: language.id}}
        params -> {:exists, params}
      end

      thing = Skill.changeset(params)
      |> Repo.insert_or_update!

      case operation do
        :not_found ->
          Enum.each solves, fn ({key, val}) ->
            skill = Skill.create_or_update! key
            thing
            |> AnswerService.solve(skill, val)
          end
      end

      thing
    end
  end
end
