class StaticArray
  def initialize(length)
    self.store = Array.new(length, nil)
  end

  # O(1) time look up
  def [](index)
    store[index]
  end

  # O(1) time reassignment
  def []=(index, value)
    store[index] = value
  end

  protected
  attr_accessor :store
end

#this data structure only allows for lookup and reassignment of values

#This static array class is built this way to recreate contiguous memory allocation
# to resemble static arrays in C
