module Egi
  VERSION = File.read(File.join(File.dirname(__FILE__), %w[ .. VERSION ])).chomp

  autoload :Sandbox, 'egi/sandbox'
  autoload :Env,     'egi/env'
  autoload :Group,   'egi/group'
  autoload :Item,    'egi/item'

  def env
    load_file(config_file) unless @env

    name = ENV['EGI_ENV'] || 'default'
    self[name]
  end
  
  def [](name)
    @env.has_key?(name) ? @env[name] : nil
  end

  def load_file(file)
    load(File.read(file))
  end

  def load(str)
    @env = Sandbox.new.eval(str)
  end

  def reset
    @env = nil
  end
  def config_file
    @config_file || 
      ( File.exist?('./egi.conf')    && './egi.conf' ) ||
      ( File.exist?('/etc/egi.conf') && '/etc/egi.conf') ||
      raise('you should set Egi.config_file or put ./egi.conf or /etc/egi.conf')
  end

  def config_file=(file)
    @config_file = file
  end

  module_function :env, :[], :load, :reset, :config_file, :config_file=
end
