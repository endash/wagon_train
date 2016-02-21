module WagonTrain
  class Config
    def initialize wagon_file
      instance_eval(wagon_file)
    end
  end
end