module Egi
  class Sandbox
    def initialize
      @current_env = :default
    end

    def envs
      @envs ||= Hash.new {|hash, key| hash[key] = Env.new(key) }
    end

    def env(name, opts = {}, &block)
      name = name.to_sym
      @current_env = name
      
      to_load = opts[:load]
      env = envs[name]
      env.merge!(envs[to_load]) if envs.has_key?(to_load)
      env.instance_eval(&block) if block_given?
      
      # define method_missing to access item
      def env.method_missing(name, *args)
        raise MethodMissing if args.size > 0
        items.has_key?(name) ? items[name] : nil
      end
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
