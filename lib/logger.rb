class Logger
  def self.info(msg, verbose: true)
    if verbose
      puts msg
      puts "." * 40
    end
  end
end