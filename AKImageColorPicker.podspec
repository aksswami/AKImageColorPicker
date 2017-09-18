Pod::Spec.new do |s|
  s.name             = 'AKImageColorPicker'
  s.version          = '0.2.0'
  s.summary          = 'Simple Image Color picker.'

  s.description      = <<-DESC
                      Now create color picker for any image with this simple AKImageColorPicker ImageView.
                       DESC

  s.homepage         = 'https://github.com/aksswami/AKImageColorPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Amit Kumar Swami' => 'aks.swami@live.com' }
  s.source           = { :git => 'https://github.com/aksswami/AKImageColorPicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'AKImageColorPicker/ColorPicker/*.swift'

end
