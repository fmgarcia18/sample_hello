defmodule SampleHelloWeb.BankLiveTest do
  use SampleHelloWeb.ConnCase

  import Phoenix.LiveViewTest
  import SampleHello.BanksFixtures

  @create_attrs %{code: "some code", description: "some description", createdBy: "some createdBy", lastModifiedBy: "some lastModifiedBy", versionNumber: 42, cuit: "some cuit"}
  @update_attrs %{code: "some updated code", description: "some updated description", createdBy: "some updated createdBy", lastModifiedBy: "some updated lastModifiedBy", versionNumber: 43, cuit: "some updated cuit"}
  @invalid_attrs %{code: nil, description: nil, createdBy: nil, lastModifiedBy: nil, versionNumber: nil, cuit: nil}

  defp create_bank(_) do
    bank = bank_fixture()
    %{bank: bank}
  end

  describe "Index" do
    setup [:create_bank]

    test "lists all banks", %{conn: conn, bank: bank} do
      {:ok, _index_live, html} = live(conn, ~p"/banks")

      assert html =~ "Listing Banks"
      assert html =~ bank.code
    end

    test "saves new bank", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/banks")

      assert index_live |> element("a", "New Bank") |> render_click() =~
               "New Bank"

      assert_patch(index_live, ~p"/banks/new")

      assert index_live
             |> form("#bank-form", bank: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank-form", bank: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/banks")

      html = render(index_live)
      assert html =~ "Bank created successfully"
      assert html =~ "some code"
    end

    test "updates bank in listing", %{conn: conn, bank: bank} do
      {:ok, index_live, _html} = live(conn, ~p"/banks")

      assert index_live |> element("#banks-#{bank.id} a", "Edit") |> render_click() =~
               "Edit Bank"

      assert_patch(index_live, ~p"/banks/#{bank}/edit")

      assert index_live
             |> form("#bank-form", bank: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank-form", bank: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/banks")

      html = render(index_live)
      assert html =~ "Bank updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes bank in listing", %{conn: conn, bank: bank} do
      {:ok, index_live, _html} = live(conn, ~p"/banks")

      assert index_live |> element("#banks-#{bank.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#banks-#{bank.id}")
    end
  end

  describe "Show" do
    setup [:create_bank]

    test "displays bank", %{conn: conn, bank: bank} do
      {:ok, _show_live, html} = live(conn, ~p"/banks/#{bank}")

      assert html =~ "Show Bank"
      assert html =~ bank.code
    end

    test "updates bank within modal", %{conn: conn, bank: bank} do
      {:ok, show_live, _html} = live(conn, ~p"/banks/#{bank}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bank"

      assert_patch(show_live, ~p"/banks/#{bank}/show/edit")

      assert show_live
             |> form("#bank-form", bank: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bank-form", bank: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/banks/#{bank}")

      html = render(show_live)
      assert html =~ "Bank updated successfully"
      assert html =~ "some updated code"
    end
  end
end
