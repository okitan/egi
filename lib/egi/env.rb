module Egi
  class Env
    def initialize(name)
      @name    = name
      @default = {}
    end

    def set(default = {})
      @default = default
    end

    def merge!(other)
      other = (other.is_a?(Env) ? other.items : other)
      # because items has default proc and cannnot dump
      items.merge!(Marshal.load(Marshal.dump(Hash[other])))
    end

    def group(name = nil, &block)
      items.merge!(Class.new(Group).new(name).instance_eval(&block).items)
    end

    def items
      @items ||= Hash.new {|hash, key| hash[key] = Item[{ :name => key }.merge(@default)] }
    end

    def item(name, hash = {})
      items[name.to_sym].update(hash)
    end

    def [](name)
      items[name.to_sym]
    end
  end
end
