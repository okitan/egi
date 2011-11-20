module Egi
  class Sandbox
    def initialize
      @current_env = :default
    end

    def envs
      @envs ||= Hash.new {|hash, key| hash[key] = Env.new(key) }
    end

    def env(name, &block)
      name = name.to_sym
      @current_env = name
      envs[name].instance_eval(&block) if block_given?
    end

    def eval(str)
      instance_eval(str)
      envs
    end

    def method_missing(name, *args)
      envs[@current_env].send(name, *args)
    end
  end
end
