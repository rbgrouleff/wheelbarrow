module Wheelbarrow
  def Command cmd_name, args
    Commands.const_get(cmd_name.capitalize).new args
  end

  module Commands
    class Command
      def initialize args
        @args = parse_args args
      end

      protected

      def self.flag name, options = {}
      end

      private

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
