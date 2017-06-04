defmodule Org.Forbidden do
  defexception [message: "Forbidden", plug_status: 403]
end
