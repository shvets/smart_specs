class SmartSpec
  attr_reader :dir

  def initialize dir
    @dir = File.expand_path(dir)
  end

  def execute pattern, line_number
    list = spec_files(pattern)

    if list.size == 0
      puts "No spec matches."
    elsif list.size > 1
      puts "Available specs:"

      puts list
    else
      cmd = "spec"

      cmd += " #{list.first}"

      if line_number > 0
        cmd += " -l #{line_number}"
      end

      system cmd
    end
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

  private

  def short_name full_name
    full_name[dir.length+1..-1]
  end

end
