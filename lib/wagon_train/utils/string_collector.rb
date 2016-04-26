module WagonTrain
  class StringCollector
    include Enumerable
    def each(&block); @strings.each(&block); end

    def initialize
      @strings = []
      @indent_level = 0
      @indent_string = "  "
    end


    def to_s
      @strings.join("\n")
    end

    def to_a
      @strings
    end

    def add_string(string)
      @strings << @indent_string * @indent_level + string
    end
    alias_method :<<, :add_string

    def indent(amount=1, &block)
      increase_indent(amount)
      block.call
      decrease_indent(amount)
    end

    def block(string, &block)
      self << string
      indent do
        block.call
      end
      self << "end"
    end

    def newline
      self << ""
    end

    def increase_indent(amount=1)
      @indent_level += amount
    end

    def decrease_indent(amount=1)
      @indent_level -= amount if @indent_level >= amount
    end
  end
end
