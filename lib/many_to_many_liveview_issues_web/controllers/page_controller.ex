defmodule ManyToManyLiveviewIssuesWeb.PageController do
  use ManyToManyLiveviewIssuesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
