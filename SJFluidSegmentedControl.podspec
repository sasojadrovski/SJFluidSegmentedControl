Pod::Spec.new do |s|

s.name             = 'SJFluidSegmentedControl'
s.version          = '1.1.3'
s.summary          = 'A segmented control with custom appearance and interactive animations.'

s.description      = <<-DESC
SJFluidSegmented control is a segmented control written in Swift with custom appearance and transition between the segments. It can be easily customized to suit your specific needs.
DESC

s.homepage         = 'https://github.com/sasojadrovski/SJFluidSegmentedControl'
s.screenshots      = 'https://raw.githubusercontent.com/sasojadrovski/SJFluidSegmentedControl/master/Screenshots/screenshot1.png', 'https://raw.githubusercontent.com/sasojadrovski/SJFluidSegmentedControl/master/Screenshots/screenshot2.png', 'https://raw.githubusercontent.com/sasojadrovski/SJFluidSegmentedControl/master/Screenshots/screenshot3.png'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Sasho Jadrovski' => 'saso.jadrovski@gmail.com' }
s.source           = { :git => 'https://github.com/sasojadrovski/SJFluidSegmentedControl.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/sasojadrovski'

s.ios.deployment_target = '8.0'

s.source_files = 'SJFluidSegmentedControl/Classes/**/*'

end
