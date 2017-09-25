require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(1)
  def pop
    raise 'There are no items' if length < 1

    value = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(value)
    resize! if length == capacity

    self.length += 1
    store[length - 1] = value

    # return the updated array
    self.store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'There are no items' if length < 1

    value = self[0]
    (1...length).each { |i| self[i - 1] = self[i] }
    self[length - 1] = nil
    self.length -= 1


    value
  end

  # O(n): has to shift over all the elements.
  def unshift(value)
    resize! if length == capacity

    self.length += 1
    (length - 2).downto(0).each { |i| self[i + 1] = self[i] }
    self[0] = value


    # return the updated array
    self.store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise 'Invalid index'
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    self.capacity = new_capacity
    self.store = new_store
  end
end
