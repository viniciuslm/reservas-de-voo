defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf, id \\ UUID.uuid4())

  def build(name, email, cpf, id) when is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       id: id,
       name: name,
       email: email,
       cpf: cpf
     }}
  end

  def build(_name, _email, _cpf, _id), do: {:error, "Cpf must be a String"}
end
