Pod::Spec.new do |s|
    s.name = 'HTBlock'
    s.version = '0.1.0'
    s.summary = 'Some block additions for UIKit.'
    s.homepage = 'https://bitbucket.org/hardtack/htblock'
    s.author = { 'Geonu Choi' => '6566gun@gmail.com' }
    s.source = { :git => "https://github.com/Hardtack/HTBlock.git", :tag => "0.1.0" }
    s.platform = :ios, '5.0'
    s.requires_arc = true
    s.source_files = 'HTBlock/*.{h, m}'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.frameworks = 'UIKit'
end
