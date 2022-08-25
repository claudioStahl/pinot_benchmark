defmodule Mix.Tasks.App.CreateOfflineTranscripts do
  use Mix.Task

  @requirements ["app.start"]

  def run(_args) do
    App.CreateOfflineTranscriptsTask.run()
  end
end
