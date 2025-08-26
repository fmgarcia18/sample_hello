defmodule SampleHelloWeb.BankLive.Show do
  use SampleHelloWeb, :live_view

  alias SampleHello.Banks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bank, Banks.get_bank!(id))}
  end

  defp page_title(:show), do: "Show Bank"
  defp page_title(:edit), do: "Edit Bank"
end
