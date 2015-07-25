defmodule Exlsx do
  use Application
  use Silverb,  [
                  {"@default_opts", %{separator: ";", header: true}},
                  {"@filename", "file"}
                ]
  use Logex, [ttl: 100]

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Exlsx.notice("cleanup tmp files #{inspect :os.cmd('rm -rf #{Exutils.priv_dir(:exlsx)}/*')}")
    children = [
      # Define workers and child supervisors to be supervised
      # worker(Exlsx.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exlsx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def encode(lst = [_|_], opts \\ @default_opts) do 
    dirname = Exutils.priv_dir(:exlsx)<>"/"<>:ossp_uuid.make(:v4, :text)
    File.mkdir!(dirname)
    try do
      File.write!(dirname<>"/#{@filename}.csv", Csvex.encode(lst, opts))
      :os.cmd('cd #{dirname} && csv2xlsx \'utf-8\' #{@filename} < ./#{@filename}.csv > ./#{@filename}.xlsx && soffice --headless --convert-to xls ./#{@filename}.xlsx && rm -rf ./#{@filename}.csv && soffice --headless --convert-to xlsx ./#{@filename}.xls && rm -rf ./#{@filename}.xls')
      content = File.read!(dirname<>"/#{@filename}.xlsx")
      cleanup(dirname)
      content
    catch 
      error -> 
        Exlsx.error(inspect(error)<>" try do cleanup")
        cleanup(dirname)
        raise(inspect(error))
    rescue
      error -> 
        Exlsx.error(inspect(error)<>" try do cleanup")
        cleanup(dirname)
        raise(inspect(error))
    end
  end

  defp cleanup(dirname) do
    case File.exists?(dirname) do
      false -> :ok
      true -> File.rm_rf!(dirname)
    end
  end

end
