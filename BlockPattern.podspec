Pod::Spec.new do |s|
  s.name     = 'BlockPattern'
  s.version  = '1.0'
  s.license  = 'MIT'
  s.summary  = 'Draw UIColor Patterns with Blocks'
  s.homepage = 'https://github.com/bigkm/UIColor-BlockPattern'
  s.authors  = { 'Kim Hunter' => 'bigkm1@gmail.com' }
  s.source   = { :git => 'https://github.com/bigkm/UIColor-BlockPattern.git', :tag => '1.0' }
  s.source_files = 'src'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'

end