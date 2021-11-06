defmodule Exercism.Binaries.FileSniffer do
  @moduledoc """
  You have been working on a project which allows users to upload files to the server to be shared with other users. You have been tasked with writing a function to verify that an upload matches its media type. You do some research and discover that the first few bytes of a file are generally unique to that file type, giving it a sort of signature.

  Use the following table for reference:

  | File type |	Common extension | Media type	                | binary 'signature'                             |
  | --------- | ---------------- | -------------------------- | ---------------------------------------------- |
  | ELF	      | "exe"	           | "application/octet-stream"	| 0x7F, 0x45, 0x4C, 0x46                         |
  | BMP	      | "bmp"	           | "image/bmp"	              | 0x42, 0x4D                                     |
  | PNG	      | "png"	           | "image/png"	              | 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A |
  | JPG	      | "jpg"	           | "image/jpg"	              |0xFF, 0xD8, 0xFF                                |
  | GIF	      | "gif"	           | "image/gif"	              |0x47, 0x49, 0x46                                |
  """
  @spec type_from_extension(String.t()) :: String.t()
  @doc """
  Implement the type_from_extension/1 function. It should take a file extension (string) and return the media type (string).

  ### Example

  iex> FileSniffer.type_from_extension("exe")
  "application/octet-stream"
  """
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
    end
  end

  @spec type_from_binary(binary) :: String.t()
  @doc """
  Implement the type_from_binary/1 function. It should take a file (binary) and return the media type (string).
  """
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: type_from_extension("exe")
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: type_from_extension("bmp")

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: type_from_extension("png")

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: type_from_extension("jpg")
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")

  @spec verify(binary, String.t()) :: {:error, String.t()} | {:ok, String.t()}
  @doc """
  Implement the verify/2 function. It should take a file (binary) and extension (string) and return an :ok or :error tuple.
  """
  def verify(file_binary, extension) do
    if type_from_extension(extension) == type_from_binary(file_binary) do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
