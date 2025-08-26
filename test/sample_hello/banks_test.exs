defmodule SampleHello.BanksTest do
  use SampleHello.DataCase

  alias SampleHello.Banks

  describe "banks" do
    alias SampleHello.Banks.Bank

    import SampleHello.BanksFixtures

    @invalid_attrs %{code: nil, description: nil, createdBy: nil, lastModifiedBy: nil, versionNumber: nil, cuit: nil}

    test "list_banks/0 returns all banks" do
      bank = bank_fixture()
      assert Banks.list_banks() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert Banks.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      valid_attrs = %{code: "some code", description: "some description", createdBy: "some createdBy", lastModifiedBy: "some lastModifiedBy", versionNumber: 42, cuit: "some cuit"}

      assert {:ok, %Bank{} = bank} = Banks.create_bank(valid_attrs)
      assert bank.code == "some code"
      assert bank.description == "some description"
      assert bank.createdBy == "some createdBy"
      assert bank.lastModifiedBy == "some lastModifiedBy"
      assert bank.versionNumber == 42
      assert bank.cuit == "some cuit"
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      update_attrs = %{code: "some updated code", description: "some updated description", createdBy: "some updated createdBy", lastModifiedBy: "some updated lastModifiedBy", versionNumber: 43, cuit: "some updated cuit"}

      assert {:ok, %Bank{} = bank} = Banks.update_bank(bank, update_attrs)
      assert bank.code == "some updated code"
      assert bank.description == "some updated description"
      assert bank.createdBy == "some updated createdBy"
      assert bank.lastModifiedBy == "some updated lastModifiedBy"
      assert bank.versionNumber == 43
      assert bank.cuit == "some updated cuit"
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_bank(bank, @invalid_attrs)
      assert bank == Banks.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = Banks.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = Banks.change_bank(bank)
    end
  end
end
