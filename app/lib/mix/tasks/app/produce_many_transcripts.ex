defmodule Mix.Tasks.App.ProduceManyTranscripts do
  use Mix.Task

  @requirements ["app.start"]

  def run(_args) do
    App.ProduceManyTranscriptsTask.run()
  end
end
