defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  def generate(from_date, to_date, filename \\ "report_from_date_to_date.csv") do
    booking_list = build_booking_list(from_date, to_date)

    File.write(filename, booking_list)
  end

  defp build_booking_list() do
    BookingsAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  defp build_booking_list(from_date, to_date) do
    BookingsAgent.list_all()
    |> Map.values()
    |> Enum.filter(&find_booking(&1, from_date, to_date))
    |> Enum.map(&booking_string(&1))
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    '#{user_id},#{local_origin},#{local_destination},#{complete_date}\n'
  end

  defp find_booking(%Booking{complete_date: complete_date} = booking, from_date, to_date) do
    if compare_from_date(NaiveDateTime.compare(from_date, complete_date)) &&
         compare_to_date(NaiveDateTime.compare(to_date, complete_date)) do
          booking
    end
  end

  defp compare_from_date(:eq), do: true
  defp compare_from_date(:lt), do: true
  defp compare_from_date(_), do: false

  defp compare_to_date(:eq), do: true
  defp compare_to_date(:gt), do: true
  defp compare_to_date(_), do: false
end
