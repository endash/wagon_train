module WagonTrain
  module Visitor
    def visit(subject)
      method_name = "visit_#{WagonTrain::Util.underscore_string(subject.class.name.split('::').last)}".to_sym
      send(method_name, subject)
    end
  end

  module Visitable
    def accept(visitor)
      visitor.visit(self)
    end
  end
end