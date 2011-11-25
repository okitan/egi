module Egi
  class Item < Hash
    def initialize(ifnone = nil, &block)
      super
      self[:tags] ||= []
    end

    def update(other)
      if tags = other.delete(:tags)
        self[:tags] += Array(tags)
      end

      super
    end
  end
end
