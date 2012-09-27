module Wheelbarrow
  class Wagonload
    def initialize(deployment_dir, repo)
      @deployment_dir = deployment_dir
      @repo = repo
    end

    # Git pull from repo to deploy dir
    def pull
    end

    # rake db:migrate
    def run_migrations
    end

    # asset precompiling
    def assets_precompiling
    end

    # restart unicorn
    def restart_unicorn
    end
  end
end
