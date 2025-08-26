defmodule SampleHelloWeb.PageController do
  use SampleHelloWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    #render(conn, :home, layout: false)
    conn
    |> put_layout(html: :app)
    |> render(:home)
  end
end
