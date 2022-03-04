defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings

  def start_agents do
    BookingsAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
end
