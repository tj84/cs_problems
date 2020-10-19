class PrioirtyQueue
    attr_reader :elements
    def initialize
        @elements = []
    end
    
    def <<(element)
        @elements << element
    end

    def push(element)
        self <<(element)
    end

    def empty?
        @elements.empty?
    end

    def pop
        @elements.sort!
        @elements.delete_at(0)
    end
end