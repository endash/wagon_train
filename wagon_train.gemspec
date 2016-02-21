$LOAD_PATH.unshift 'lib'

Gem::Specification.new do |s|
  s.name              = "wagon_train"
  s.version           = "0.0.1"
  s.date              = "2012-02-14"
  s.summary           = "Database schema & migration independent of your apps"
  s.homepage          = "http://github.com/endash/wagon_train"
  s.email             = "christopher.swasey@gmail.com"
  s.authors           = [ "Christopher Swasey" ]
  s.has_rdoc          = false
  s.files             = %w( README.md Gemfile Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.description       = "Database schema & migration independent of your apps"
  s.executables       = ["wagon"]

  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "sequel"
  s.add_runtime_dependency "git"
end