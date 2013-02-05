require 'script_executor'

module SmartSpecs
  class Cli
    attr_reader :dir

    def initialize dir
      @dir             = File.expand_path(dir)
      @script_executor = ScriptExecutor.new
    end

    USAGE= <<-TEXT
    Usage:
      spec! user       - executes spec based on <user> pattern
      spec! user -l 65 - executes spec based on <user> pattern in line 65
      spec! --list     - displays list of all available specs
      spec! --list us  - displays list of available specs that satisfies <us> pattern
    TEXT

    def run params
      if params.size > 0
        case params[0]

          when /(-h)|(--help)/
            usage

          when /(-v)|(--version)/
            version

          when /(-i)|(--list)/
            list params

          else
            search params

        end
      else
        search params
      end
    end

    private

    def usage
      puts USAGE
    end

    def version
      puts "spec! version: #{SmartSpecs::VERSION}"
    end

    def list params
      pattern = (params.size > 1) ? params[1] : ""

      list = spec_files(pattern)

      puts list
    end

    def search params
      line_number = 0
      pattern     = params[0]

      if params.size > 2
        arg = params[1]

        if arg =~ /(-l)|(--line)/
          line_number = params[2].to_i
        end
      end

      list = spec_files(pattern)

      if list.size == 0
        puts "No spec matches."
      elsif list.size > 1
        puts "Available specs:"

        list.each_with_index do |name, index|
          puts "#{index+1}. #{name}"
        end

        choice = ask("Select spec:")

        execute list[choice.to_i-1], 0
      else
        execute list.first, line_number
      end
    end

    def execute spec_name, line_number
      spec_version = Gem.searcher.find("rspec").version.to_s

      cmd = (spec_version =~ /^2/) ?"rspec" : "spec"

      cmd += " #{spec_name}"

      if line_number > 0
        cmd += " -l #{line_number}"
      end

      @script_executor.execute cmd
    end

    def spec_files pattern
      Dir.glob("#{dir}/spec/**/*_spec.rb").inject([]) do |list, spec_name|
        name = short_name spec_name

        if name =~ /#{pattern}/
          list << name
        end

        list
      end
    end

    def short_name full_name
      full_name[dir.length+1..-1]
    end
  end
end