#《指路者地图》iOS版本

## 如何编译
- 先安装`CocoaPods`
  - $ gem sources --remove https://rubygems.org/
  - $ gem sources -a https://ruby.taobao.org/
  - $ sudo gem install cocoapods
- 查找高德三个库
  - $ pod search AMapNavi
  - $ pod search AMapSearch
  - $ pod search AMapLocation
- 查找入json解析库
  - $ pod search JSONModel
- 导入上述依赖库
  - $ pod install

执行完上面的步骤之后，就会在目录想生成一个后缀是`.xcworkspace`的文件。用`xcode`打开就可以了。

## 注意
> 我由于我刚开始学习`iOS`开发，如果你编译过程中出现问题，我可能也不清楚原因。
> 但我觉得如果你的开发环境跟我一样，应该不会有问题。

## 开发环境
- xcode 7.1.1（7B005）
- iPhone 5s iOS 9.0.2
