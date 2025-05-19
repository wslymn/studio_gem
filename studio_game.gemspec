Gem::Specification.new do |spec|
    spec.name        = "wsmn_studio_game"
    spec.version     = "1.0.0"
    spec.author      = "Wes Moon"
    spec.email       = "wesmoon51@gmail.com"
    spec.summary     = "dice rolling game with multiple players"
    spec.homepage    = "https://github.com/wslymn/studio_gem"
    spec.license     = "MIT"
  
    spec.files       = Dir["{bin,lib}/**/*"] + %w[LICENSE.txt README.md]
    spec.executables = ["studio_game"]
  
    spec.required_ruby_version = ">= 3.2.0"
  end