Gem::Specification.new do |s|
  s.name    = "ysd_md_configuration"
  s.version = "0.2.12"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-05-09"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','spec/**/*.rb']
  s.summary = "A DattaMapper-based model for configuration"
  s.homepage = "http://github.com/yuraksisa/ysd_md_configuration"
    
  s.add_runtime_dependency "data_mapper", "1.2.0"
  s.add_runtime_dependency "dm-ysd-encrypted"
  s.add_runtime_dependency "ysd_md_yito"
  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "dm-sqlite-adapter" # Model testing using sqlite
  
end
