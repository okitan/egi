module Egi
  VERSION = File.read(File.join(File.dirname(__FILE__), %w[ .. VERSION ])).chomp

  autoload :Sandbox, 'egi/sandbox'
  autoload :Env,     'egi/env'
  autoload :Group,   'egi/group'
  autoload :Item,    'egi/item'

  def env
    name = ENV['EGI_ENV'] || 'default'
    self[name]
  end
  
  def [](name)
    @env.has_key?(name) ? @env[name] : nil
  end

  def load(str)
    @env = Sandbox.new.eval(str)
  end

  def reset
    @env = nil
  end
  module_function :[], :load, :reset
end
