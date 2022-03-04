defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings
  alias Bookings.Agent, as: BookingsAgent
  alias Bookings.Booking

  def call(%{
    complete_date: complete_date,
    local_origin: local_origin,
    local_destination: local_destination,
    user_id: user_id
  }) do
    complete_date
    |> Booking.build(local_origin, local_destination, user_id)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingsAgent.save(booking)
  end

  defp save_booking({:error, _reason} = error), do: error
end