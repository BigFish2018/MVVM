platform :ios, '8.0'

def commonPods #通用pods集
pod 'AFNetworking'
pod 'Masonry'
pod 'ReactiveObjC', '~> 3.0'
end

def appOnlyPods #app专用pods集
pod 'MBProgressHUD'
end

def extensionPods #扩展专用pods集
pod 'GTSDKExtension'
end

target :FirstRAC do
commonPods
appOnlyPods
end

