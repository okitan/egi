module Egi
  class Group
    def initialize(name = nil)
      @tags = name ? [ name ] : [ ]
    end

    def items
      @items ||= Hash.new {|hash, key| hash[key] = Item[:name => key, :tags => @tags] }
    end

    def item(name, hash)
      items[name.to_sym].update(hash)
      self # for method chain
    end
  end
end

