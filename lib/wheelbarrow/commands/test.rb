module Wheelbarrow
  module Commands
    class Test < Command
      flag :h, description: "HEEEEEELP" do
        puts help
      end
    end
  end
end
