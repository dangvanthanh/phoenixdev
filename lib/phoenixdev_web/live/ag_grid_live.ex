defmodule PhoenixdevWeb.AgGridLive do
  use PhoenixdevWeb, :live_view

  def render(assigns) do
    ~H"""
    <div id="ag-grid" phx-hook="AgGridHook" phx-update="ignore" class="h-[500px]"></div>
    """
  end

  def handle_params(_params, _uri, socket) do
    gridOptions = %{
      columnDefs: column_defs(),
      rowData: list_records(),
      defaultColDef: %{
        filter: true,
        sortable: true,
        resizable: true
      }
    }

    socket = push_event(socket, "load-grid", gridOptions)
    {:noreply, socket}
  end

  defp column_defs do
    [
      %{field: "continent"},
      %{field: "country"},
      %{field: "city"},
      %{field: "population", type: ["numericThousandSeparator"]},
      %{
        field: "airports",
        headerName: "Airports",
        type: ["airport_links", "array_length_comparator"],
        cellDataTypes: false
      }
    ]
  end

  defp list_records do
    [
      %{
        continent: "Europe",
        country: "Austria",
        city: "Vieena",
        population: 1_800_000,
        airports: ["VIE"]
      },
      %{
        continent: "Asia",
        country: "Japan",
        city: "Tokyo",
        population: 37_400_068,
        airports: ["HND", "NRT"]
      },
      %{
        continent: "Asia",
        country: "India",
        city: "New Delhi",
        population: 1_450_935_791,
        airports: ["BOM"]
      },
      %{
        continent: "Asia",
        country: "China",
        city: "Beijing",
        population: 1_419_321_278,
        airports: ["DEL"]
      },
      %{
        continent: "America",
        country: "United States",
        city: "Washington, D.C.",
        population: 345_426_571,
        airports: ["LAX", "SFO", "PDX"]
      },
      %{
        continent: "Asia",
        country: "Vietnam",
        city: "Ha Noi",
        population: 100_987_686,
        airports: ["HAN", "HUE"]
      }
    ]
  end
end
