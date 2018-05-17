# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'WeekPhotos' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeekPhotos
  # Dependency Injection
  pod 'Swinject'
  pod 'SwinjectStoryboard'

  #Rx Pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'Moya/RxSwift'


  def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
  end
  target 'WeekPhotosTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
