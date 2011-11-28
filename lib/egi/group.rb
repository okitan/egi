module Egi
  class Group
    def initialize(name = nil)
      @tags = name ? [ name ] : [ ]
      @default = {}
    end

    def set(default)
      @default = default
    end

    def instance_eval(&block)
      super
      self # for method chain
    end

    def items
      @items ||= Hash.new {|hash, key| hash[key] = Item[{ :name => key, :tags => @tags }.merge(@default)] }
    end

    def item(name, hash = {})
      items[name.to_sym].update(hash)
      self # for method chain
    end
  end
end

