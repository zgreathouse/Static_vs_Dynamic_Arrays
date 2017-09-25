class StaticArray
  def initialize(length)
    self.store = Array.new(length, nil)
  end

  # O(1) time
  def [](index)
    store[index]
  end

  # O(1) time
  def []=(index, value)
    store[index] = value
  end

  protected
  attr_accessor :store
end
