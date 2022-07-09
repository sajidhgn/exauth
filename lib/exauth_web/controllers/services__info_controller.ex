defmodule ExauthWeb.Services_InfoController do
  use ExauthWeb, :controller

  alias Exauth.Services_Infos
  alias Exauth.Services_Infos.Services_Info

  action_fallback ExauthWeb.FallbackController

  def index(conn, _params) do
    services_infos = Services_Infos.list_services_infos()
    render(conn, "index.json", services_infos: services_infos)
  end

  def create(conn, %{"services__info" => services__info_params}) do
    with {:ok, %Services_Info{} = services__info} <- Services_Infos.create_services__info(services__info_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.services__info_path(conn, :show, services__info))
      |> render("show.json", services__info: services__info)
    end
  end

  def show(conn, %{"id" => id}) do
    services__info = Services_Infos.get_services__info!(id)
    render(conn, "show.json", services__info: services__info)
  end

  def update(conn, %{"id" => id, "services__info" => services__info_params}) do
    services__info = Services_Infos.get_services__info!(id)

    with {:ok, %Services_Info{} = services__info} <- Services_Infos.update_services__info(services__info, services__info_params) do
      render(conn, "show.json", services__info: services__info)
    end
  end

  def delete(conn, %{"id" => id}) do
    services__info = Services_Infos.get_services__info!(id)

    with {:ok, %Services_Info{}} <- Services_Infos.delete_services__info(services__info) do
      send_resp(conn, :no_content, "")
    end
  end
end
