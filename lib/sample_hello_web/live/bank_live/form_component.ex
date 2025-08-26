defmodule SampleHelloWeb.BankLive.FormComponent do
  use SampleHelloWeb, :live_component

  alias SampleHello.Banks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage bank records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bank-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:createdBy]} type="text" label="Createdby" />
        <.input field={@form[:lastModifiedBy]} type="text" label="Lastmodifiedby" />
        <.input field={@form[:versionNumber]} type="number" label="Versionnumber" />
        <.input field={@form[:code]} type="text" label="Code" />
        <.input field={@form[:cuit]} type="text" label="Cuit" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bank</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bank: bank} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Banks.change_bank(bank))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bank" => bank_params}, socket) do
    changeset = Banks.change_bank(socket.assigns.bank, bank_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bank" => bank_params}, socket) do
    save_bank(socket, socket.assigns.action, bank_params)
  end

  defp save_bank(socket, :edit, bank_params) do
    case Banks.update_bank(socket.assigns.bank, bank_params) do
      {:ok, bank} ->
        notify_parent({:saved, bank})

        {:noreply,
         socket
         |> put_flash(:info, "Bank updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bank(socket, :new, bank_params) do
    case Banks.create_bank(bank_params) do
      {:ok, bank} ->
        notify_parent({:saved, bank})

        {:noreply,
         socket
         |> put_flash(:info, "Bank created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
