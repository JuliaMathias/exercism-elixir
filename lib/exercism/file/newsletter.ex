defmodule Exercism.File.Newsletter do
  @moduledoc """
  You're a big model train enthusiast and have decided to share your passion with the world by starting a newsletter. You'll start by sending the first issue of your newsletter to your friends and acquaintances that share your hobby. You have a text file with a list of their email addresses.
  """

  @spec read_emails(String.t()) :: list
  @doc """
  Implement the Newsletter.read_emails/1 function. It should take a file path. The file is a text file that contains email addresses separated by newlines. The function should return a list of the email addresses from the file.

  ### Example
  Newsletter.read_emails("/home/my_user/documents/model_train_friends_emails.txt")
  iex> ["rick@example.com", "choochoo42@example.com", "anna@example.com"]

  """
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
  end

  @spec open_log(String.t()) :: pid
  @doc """
  Sending an email is a task that might fail for many unpredictable reasons, like a typo in the email address or temporary network issues. To ensure that you can retry sending the emails to all your friends without sending duplicates, you need to log the email addresses that already received the email. For this, you'll need a log file.

  Implement the Newsletter.open_log/1 function. It should take a file path, open the file for writing, and return the PID of the process that handles the file.

  ### Example

  iex> Newsletter.open_log("/home/my_user/documents/newsletter_issue1_log.txt")
  #PID<0.145.0>
  """
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(pid, String.t()) :: :ok
  @doc """
  Implement the Newsletter.log_sent_email/2 function. It should take a PID of the process that handles the file and a string with the email address. It should write the email address to the file, followed by a newline.

  ### Example
  Newsletter.log_sent_email(pid, "joe@example.com")
  iex> :ok

  """
  def log_sent_email(pid, email), do: IO.puts(pid, email)

  @spec close_log(pid) :: :ok | {:error, atom}
  @doc """
  Implement the Newsletter.close_log/1 function. It should take a PID of the process that handles the file and close the file.

  ### Example
  Newsletter.close_log(pid)
  iex> :ok

  """
  def close_log(pid), do: File.close(pid)

  @spec send_newsletter(binary, binary, any) :: :ok | {:error, atom}
  @doc """
  Now that you have all of the building blocks of the email sending procedure, you need to combine them together in a single function.

  Implement the Newsletter.send_newsletter/3 function. It should take a path of the file with email addresses, a path of a log file, and an anonymous function that sends an email to a given email address. It should read all the email addresses from the given file and attempt to send an email to every one of them. If the anonymous function that sends the email returns :ok, write the email address to the log file, followed by a new line. Make sure to do it as soon as the email is sent. Afterwards, close the log file.

  ### Example
  Newsletter.send_newsletter("model_train_friends_emails.txt", "newsletter_issue1_log.txt", fn email -> :ok end)
  iex> :ok

  """
  def send_newsletter(emails_path, log_path, send_fun) do
    email_list = read_emails(emails_path)
    pid = open_log(log_path)

    for email <- email_list do
      with :ok <- send_fun.(email) do
        log_sent_email(pid, email)
      end
    end

    close_log(pid)
  end
end
