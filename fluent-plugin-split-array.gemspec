Gem::Specification.new do |s|
  s.name          = "fluent-plugin-split-array"
  s.version       = "0.1.1"
  s.licenses      = ["MIT"]
  s.summary       = "Fluentd filter plugin to split array"
  s.description   = s.summary
  s.authors       = ["SNakano"]
  s.email         = ["pp.nakano@gmail.com"]
  s.homepage      = "https://github.com/SNakano/fluent-plugin-split-array"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "fluentd", [">= 0.14.0", "< 2"]
  s.add_development_dependency "rake", ">= 12.3.3"
  s.add_development_dependency "test-unit", "~> 3.1"
end
