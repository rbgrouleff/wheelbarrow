require "wheelbarrow/version"
require "wheelbarrow/wagonload"
require "wheelbarrow/command"
require "wheelbarrow/commands/test"

module Wheelbarrow
  def self.deploy app_dir, repo
    wagonload = new Wagonload app_dir, repo
    wagonload.pull
    wagonload.bundle_install
    wagonload.run_migrations
    wagonload.assets_precompiling
    wagonload.restart_unicorn
  end
end

cmd = Wheelbarrow.Command(ARGV[0], ARGV.drop(1))
cmd.execute if cmd
