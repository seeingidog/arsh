module ArshCommands
  def self.rvm(command)
    command = command.join(' ')
    output = %x{bash -c "source #{ENV['rvm_path']}/scripts/rvm; rvm #{command}; env | grep -i rvm"}
    output.split("\n").select { |l| l[/=/] }.each do |n|
      var, value = n.split(/=/,2)
      ENV[var] = value
    end
    case command
    when /^use /
      puts "\e[32mUsing #{ENV['GEM_HOME']}\e[0m"
    end
  end
end