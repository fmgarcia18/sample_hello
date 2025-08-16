defmodule SampleHello.Repo do
  use Ecto.Repo,
    otp_app: :sample_hello,
    adapter: Ecto.Adapters.Postgres
end
