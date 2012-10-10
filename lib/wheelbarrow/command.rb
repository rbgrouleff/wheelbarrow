module Wheelbarrow
  def self.Command cmd_name, args
    begin
      Commands.get(cmd_name.capitalize).new args
    rescue NameError => e
      raise unless e.message.include? cmd_name.capitalize
      puts "Command #{cmd_name} not found"
      puts "Available commands are: #{Commands.available_commands.join ', '}"
    end
  end

  module Commands
    def self.get name
      const_get(name)
    end

    def self.available_commands
      constants.reject { |cmd|
        cmd == :Command
      }.map { |cmd|
        cmd.to_s.downcase
      }
    end

    class Command
      def initialize args
        @args = parse_args args
      end

      def execute
        @args.each do |arg|
          flag = get_flag arg[0]
          instance_eval &flag[:action]
        end
      end

      protected

      def self.flag name, options = {}, &action
        @flags ||= {}
        @flags[name] = {
          options: options,
          action: action
        }
      end

      def self.flags
        @flags
      end

      def help
        "Yes!"
      end

      private

      def get_flag name
        name_sym = name.intern
        if flag = self.class.flags[name_sym]
          flag
        else
          flag = self.class.flags.find { |flag, conf|
            aliases = conf[:options][:alias]
            if aliases.respond_to? :include?
              aliases.include? name_sym
            else
              aliases == name_sym
            end
          }
          flag[1] if flag
        end
      end

      def parse_args args
        flags = []
        args_enum = args.to_enum
        arg = ''
        loop do
          begin
            arg = args_enum.next
          rescue StopIteration
            break
          end
          if arg.include? "="
            arg_name, arg_val = arg.split "="
            flags << [strip_dashes(arg_name), arg_val]
          elsif arg.start_with? '-'
            flags << [strip_dashes(arg)]
          else
            flags.last << arg
          end
        end
        flags
      end

      def strip_dashes str
        str[/-*([^-]*)/,1]
      end
    end
  end
end
