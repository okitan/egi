module Egi
  class Env
    def initialize(name)
      @name = name
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
