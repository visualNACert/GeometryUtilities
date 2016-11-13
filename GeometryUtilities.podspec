Pod::Spec.new do |s|

  s.name         = "GeometryUtilities"
  s.version      = "1.2.0"
  s.summary      = "A collection of utilities to handle geometry in WKT format"

  s.description  = <<-DESC
  Collection of utilities to handle geometry in WKT format, multipolygons and
  integrate both in `MapKit`.
                   DESC

  s.homepage     = "http://visualnacert.com"
  s.license      = { :type => "Propietary", :file => "LICENSE" }
  s.author       = { "Lluís Ulzurrun de Asanza i Sàez" => "lulzurrun@visualnacert.com" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"

  s.source       = {
  	:git => "git@bitbucket.org:vnac/geometryutilities.git",
  	:tag => "#{s.version}"
  }

  s.ios.source_files = 'Source/{iOS}/**/*', 'Source/*.{h,m,swift}'
  s.osx.source_files = 'Source/{macOS}/**/*', 'Source/*.{h,m,swift}'

  s.dependency 'StringUtilities', '~> 2'

end
