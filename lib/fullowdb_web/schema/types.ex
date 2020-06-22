defmodule FullowdbWeb.Schema.Types do
    use Absinthe.Schema.Notation

    alias FullowdbWeb.Schema.Types

    import_types Types.SessionTypes
    import_types Types.AccountTypes
    import_types Types.FanshopTypes
    import_types Types.MediaTypes
    import_types Types.TagTypes
end