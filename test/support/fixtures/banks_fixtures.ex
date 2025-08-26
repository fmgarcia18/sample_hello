defmodule SampleHello.BanksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SampleHello.Banks` context.
  """

  @doc """
  Generate a bank.
  """
  def bank_fixture(attrs \\ %{}) do
    {:ok, bank} =
      attrs
      |> Enum.into(%{
        code: "some code",
        createdBy: "some createdBy",
        cuit: "some cuit",
        description: "some description",
        lastModifiedBy: "some lastModifiedBy",
        versionNumber: 42
      })
      |> SampleHello.Banks.create_bank()

    bank
  end
end
