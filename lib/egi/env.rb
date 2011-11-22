module Egi
  class Env
    def initialize(name)
      @name = name
    end

    def merge!(other)
      other = (other.is_a?(Env) ? other.items : other)
      # because items has default proc and cannnot dump
      items.merge!(Marshal.load(Marshal.dump(Hash[other])))
    end

    def items
      @items ||= Hash.new {|hash, key| hash[key] = { :name => key } }
    end

    def item(name, hash)
      items[name.to_sym].merge!(hash)
    end

    def method_missing(name, *args)
      items.has_key?(name) ? items[name] : nil
    end
  end
end
