defmodule SampleHelloWeb.BankLive.Index do
  use SampleHelloWeb, :live_view

  alias SampleHello.Banks
  alias SampleHello.Banks.Bank

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :banks, Banks.list_banks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bank")
    |> assign(:bank, Banks.get_bank!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bank")
    |> assign(:bank, %Bank{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Banks")
    |> assign(:bank, nil)
  end

  @impl true
  def handle_info({SampleHelloWeb.BankLive.FormComponent, {:saved, bank}}, socket) do
    {:noreply, stream_insert(socket, :banks, bank)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bank = Banks.get_bank!(id)
    {:ok, _} = Banks.delete_bank(bank)

    {:noreply, stream_delete(socket, :banks, bank)}
  end
end
