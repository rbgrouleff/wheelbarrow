module Wheelbarrow
  class Wagonload
    def initialize(deployment_dir, repo)
      @deployment_dir = deployment_dir
      @repo = repo
    end

    # Git pull from repo to deploy dir
    def pull
      Dir.chdir @deployment_dir do
        `git pull #{@repo} master`
        raise "Deployment of code failed" unless $?.exitstatus == 0
      end
    end

    # rake db:migrate
    def run_migrations
      Dir.chdir @deployment_dir do
        puts `RAILS_ENV=production rake db:migrate`
        raise "Migrating the database failed" unless $?.exitstatus == 0
      end
    end

    # asset precompiling
    def assets_precompiling
      Dir.chdir @deployment_dir do
        puts `RAILS_ENV=production rake assets:precompile`
        raise "Assets precompiling failed" unless $?.exitstatus == 0
      end
    end

    # restart unicorn
    def restart_unicorn
    end
  end
end
