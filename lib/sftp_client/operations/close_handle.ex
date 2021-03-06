defmodule SFTPClient.Operations.CloseHandle do
  @moduledoc """
  A module that provides functions to close an open handle pointing to a file or
  directory on the SFTP server.
  """

  import SFTPClient.OperationUtil

  alias SFTPClient.Handle

  @doc """
  Closes a handle to an open file or directory on the server.
  """
  @spec close_handle(Handle.t()) :: :ok | {:error, SFTPClient.error()}
  def close_handle(%Handle{} = handle) do
    handle.conn.channel_pid
    |> sftp_adapter().close(handle.id, handle.conn.config.operation_timeout)
    |> case do
      :ok -> :ok
      {:error, error} -> {:error, handle_error(error)}
    end
  end

  @doc """
  Closes a handle to an open file or directory on the server. Raises when the
  operation fails.
  """
  @spec close_handle!(Handle.t()) :: :ok | no_return
  def close_handle!(%Handle{} = handle) do
    handle |> close_handle() |> may_bang!()
  end
end
