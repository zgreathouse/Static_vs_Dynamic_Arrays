require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @maxqueue = RingBuffer.new
  end

  def enqueue(value)
    @store.push(value)
    update_maxqueue(value)
  end

  def dequeue
    value = @store.shift
    @maxqueue.shift if value == @maxqueue[0]
    value
  end

  def max
    @maxqueue[0] if @maxqueue.length > 0
  end

  def update_maxqueue(value)
    while @maxqueue[0] && @maxqueue[@maxqueue.length-1] < value
      @maxqueue.pop
    end
    @maxqueue.push(value)
  end

  def length
    @store.length
  end
end
