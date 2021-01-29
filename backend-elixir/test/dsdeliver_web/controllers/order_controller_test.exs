defmodule DsdeliverWeb.OrderControllerTest do
  use DsdeliverWeb.ConnCase

  alias Dsdeliver.Orders
  alias Dsdeliver.Orders.Order

  @create_attrs %{
    address: "some address",
    latitude: 120.5,
    longitude: 120.5,
    status: "some status"
  }
  @update_attrs %{
    address: "some updated address",
    latitude: 456.7,
    longitude: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{address: nil, latitude: nil, longitude: nil, status: nil}

  def fixture(:order) do
    {:ok, order} = Orders.create_order(@create_attrs)
    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "latitude" => 120.5,
               "longitude" => 120.5,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
