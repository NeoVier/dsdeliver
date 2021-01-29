defmodule DsdeliverWeb.ProductControllerTest do
  use DsdeliverWeb.ConnCase

  alias Dsdeliver.Products
  alias Dsdeliver.Products.Product

  @create_attrs %{
    description: "some description",
    image_uri: "some image_uri",
    name: "some name",
    price: 120.5
  }
  @update_attrs %{
    description: "some updated description",
    image_uri: "some updated image_uri",
    name: "some updated name",
    price: 456.7
  }
  @invalid_attrs %{description: nil, image_uri: nil, name: nil, price: nil}

  def fixture(:product) do
    {:ok, product} = Products.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "image_uri" => "some image_uri",
               "name" => "some name",
               "price" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
