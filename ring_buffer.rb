require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store, self.capacity = StaticArray.new(8), 8
    self.start_idx, self.length = 0, 0
  end

  # O(1) lookup
  def [](index)
    check_index(index)
    store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[(start_idx + index) % capacity] = value
  end

  # O(1)
  def pop
    raise "There are no more items" if (length == 0)

    value = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    #return item which has been popped off the array
    value
  end

  # O(1) ammortized
  def push(value)
    resize! if (length == capacity)
    self.length += 1
    self[length - 1] = value

    # return the updated array
    self.store
  end

  # O(1)
  def shift
    raise "There are no more items" if (length == 0)

    value = self[0]
    self[0] = nil
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1

    #return item which has been shifted off the array
    value
  end

  # O(1) ammortized
  def unshift(value)
    resize! if (length == capacity)

    self.start_idx = (start_idx - 1) % capacity
    self.length += 1
    self[0] = value

    # return the updated array
    self.store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "Invalid index"
    end
  end

  # O(n) (has to copy each element over to a new store)
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i] }

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end


#resize break down:
  # everytime the amount of items in the array exceeds the capacity a
  # resize is triggered

  # the capacity is doubled on each resize to create an average case of
  # constant time (worst case Linear time)

  # a new store is also created which is a new static array with a
  # capacity of the new doubled capacity

  # then on line 65, after defining our new capcity and store, we then
  # copy the items over to our new store (array)

  # lastly we redefine our instance variables to match our new capacity,
  # store, and start_idx
