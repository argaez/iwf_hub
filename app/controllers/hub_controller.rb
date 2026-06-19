class HubController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = [
      {
        key: "inventarios",
        name: "Inventarios",
        description: "Equipos, asignaciones, colaboradores y telefonía",
        status: :active,
        path: "/avo",
        icon: "M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"
      },
      {
        key: "puestos",
        name: "Puestos de trabajo",
        description: "Checklist de recepción de puestos",
        status: :coming_soon,
        path: nil,
        icon: "M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
      },
      {
        key: "formularios",
        name: "Formularios",
        description: "Crear formularios y exportar a Magaya",
        status: :coming_soon,
        path: nil,
        icon: "M9 17h6m-6-4h6m-6-4h1m-1 12H6a2 2 0 01-2-2V5a2 2 0 012-2h7l5 5v11a2 2 0 01-2 2h-1"
      },
      {
        key: "marketing",
        name: "Marketing interno",
        description: "Campañas, cumpleaños y fechas especiales",
        status: :coming_soon,
        path: nil,
        icon: "M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"
      }
    ]
  end
end