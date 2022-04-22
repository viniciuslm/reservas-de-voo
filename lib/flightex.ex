defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings
  alias Flightex.Bookings.Report, as: ReportBookings
  alias Flightex.Users.Agent, as: UsersAgent

  def start_agents do
    BookingsAgent.start_link(%{})
    UsersAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
  defdelegate generate_report(rom_date, to_date), to: ReportBookings, as: :generate
end
