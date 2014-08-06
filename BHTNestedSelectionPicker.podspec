Pod::Spec.new do |s|

  s.name                  = 'BHTNestedSelectionPicker'
  
  s.version               = '0.0.1'
  s.summary               = 'A library for interacting with the TicketingHub Developer API from an iOS device.'
  s.homepage              = 'https://github.com/bartekhugo/BHTNestedSelectionPicker'
  s.author                = { 'Bartek Hugo' => 'bartekhugo@me.com' }
  
  s.source                = { :git => 'https://github.com/bartekhugo/BHTNestedSelectionPicker.git', :tag => s.version }
  
  s.ios.deployment_target = '7.0'
  
  s.source_files          = 'BHTNestedSelectionPicker/*.{h,m}'
  
  s.requires_arc          = true

  s.dependency 'JTTree', '~> 0.1.0'

  s.license  = 'MIT'

end
