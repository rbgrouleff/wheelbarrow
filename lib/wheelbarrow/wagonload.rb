module Wheelbarrow
  class Wagonload
    def initialize(app_dir, repo)
      @app_dir = app_dir
      @repo = repo
    end

    # Git pull from repo to deploy dir
    def pull
      Dir.chdir @app_dir do
        `git pull #{@repo} master`
        raise "Deployment of code failed" unless $?.exitstatus == 0
      end
    end

    def bundle_install
      Dir.chdir @app_dir do
        puts `bundle install --without development test && rbenv rehash`
        raise "Bundle install failed" unless $?.exitstatus == 0
      end
    end

    # rake db:migrate
    def run_migrations
      Dir.chdir @app_dir do
        puts `RAILS_ENV=production rake db:migrate`
        raise "Migrating the database failed" unless $?.exitstatus == 0
      end
    end

    # asset precompiling
    def assets_precompiling
      Dir.chdir @app_dir do
        puts `RAILS_ENV=production rake assets:precompile`
        raise "Assets precompiling failed" unless $?.exitstatus == 0
      end
    end

    # restart unicorn
    def restart_unicorn
      Dir.chdir @app_dir do
        pid = File.read(File.join('tmp', 'pids', 'unicorn.pid')).strip
        `kill -s HUP #{pid}`
        raise "Restart of unicorn failed" unless $?.exitstatus == 0
      end
    end
  end
end
