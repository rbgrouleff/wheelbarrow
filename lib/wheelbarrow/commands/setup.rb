module Wheelbarrow
  module Commands
    class Setup < Command
      flag :app_dir, alias: :a, description: "Path to the directory where the app should be deployed"
      flag :repo, alias: :r, description: "Path to the Git repository where the Git hook should be installed"
    end
  end
end
