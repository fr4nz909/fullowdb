defmodule FullowdbWeb.Resolvers.Helpers do
    
    def error_details(changeset) do
        changeset
        |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end
        )
   end

    defp transform_errors(changeset) do
        changeset
        |> Ecto.Changeset.traverse_erros(&format_error/1)
        |> Enum.map(fn
            {key, value} ->
                %{key: key, message: value}
            end)
    end

    @spec format_error(Ecto.Changeset.error) :: String.t
    defp format_error({msg, opts}) do
        Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
        end)
    end
end