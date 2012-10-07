require "wheelbarrow/version"
require "wheelbarrow/wagonload"

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



puts `ls`
puts $?.exitstatus
