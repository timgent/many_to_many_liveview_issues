defmodule ManyToManyLiveviewIssues.Repo do
  use Ecto.Repo,
    otp_app: :many_to_many_liveview_issues,
    adapter: Ecto.Adapters.Postgres
end
