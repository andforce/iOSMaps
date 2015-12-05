# iOSMaps
《指路者地图》iOS版本

## 如何编译
- 先安装`CocoaPods`
  - $ gem sources --remove https://rubygems.org/
  - $ gem sources -a https://ruby.taobao.org/
  - $ sudo gem install cocoapods
- 导入高德三个库
  - $ pod search AMapNavi
  - $ pod search AMapSearch
  - $ pod search AMapLocation
  - $ pod install

执行完上面的步骤之后，就会在目录想生成一个后缀是`.xcworkspace`的文件。用`xcode`打开就可以了。
