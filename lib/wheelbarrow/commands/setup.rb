module Wheelbarrow
  module Commands
    class Setup < Command
      flag :app_dir, short: :a, description: "Path to the directory where the app should be deployed"
      flag :repo, short: :r, description: "Path to the Git repository where the Git hook should be installed"
    end
  end
end
