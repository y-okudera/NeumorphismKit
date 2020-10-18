# NeumorphismKit

[![Version](https://img.shields.io/cocoapods/v/NeumorphismKit.svg?style=flat)](http://cocoapods.org/pods/NeumorphismKit)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/y-okudera/NeumorphismKit)
[![License](https://img.shields.io/cocoapods/l/NeumorphismKit.svg?style=flat)](http://cocoapods.org/pods/NeumorphismKit)
[![Platform](https://img.shields.io/cocoapods/p/NeumorphismKit.svg?style=flat)](http://cocoapods.org/pods/NeumorphismKit)

NeumorphismKit is neumorphism framework for UIKit.

![](https://user-images.githubusercontent.com/25205138/90653820-9e6c3300-e27a-11ea-8cc7-70a58c30d35c.png) ![](https://user-images.githubusercontent.com/25205138/90653825-a1ffba00-e27a-11ea-9ccc-46b9ade19b16.png)


## Requirements

- iOS 12.0+
- Swift 5.1+

### Versions

| NeumorphismKit version | Xcode version |
| :--------------------: | :-----------: |
|         1.0.0          |   Xcode 11+   |
|         1.1.0          |   Xcode 12+   |

## Installation

### CocoaPods

To integrate NeumorphismKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '12.0'
use_frameworks!

target '<TargetName>' do
    pod 'NeumorphismKit', '~> 1.0'
end
```

Then, run the following command:

```
$ pod install
```

### Carthage

To integrate NeumorphismKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "y-okudera/NeumorphismKit" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `NeumorphismKit.framework` into your Xcode project.

## Usage

### Storyboard
You can start NeumorphismKit on the storyboard.

1. Set 'NeumorphismButton' to a custom class of UIButton.

![Usage_1](https://user-images.githubusercontent.com/25205138/90649602-e046aa80-e275-11ea-870e-8a6828ba895e.png)

2. Set the same color as the background color of SuperView to the base color of the button.

![Usage_2](https://user-images.githubusercontent.com/25205138/90649635-e8064f00-e275-11ea-9040-6abd8cbc2c73.png)

### Code
You can also start NeumorphismKit on code.

```
let neumorphismButton = NeumorphismButton(frame: .init(x: 0, y: 0, width: 120.0, height: 40.0))
neumorphismButton.baseColor = self.view.backgroundColor ?? .white
neumorphismButton.center = self.view.center
neumorphismButton.setTitle("BUTTON", for: .normal)

let titleColor = UIColor(red: 160 / 255, green: 70 / 255, blue: 255 / 255, alpha: 1.0)
neumorphismButton.setTitleColor(titleColor, for: .normal)

self.view.addSubview(neumorphismButton)
```



#### NeumorphismTabBarController

<img width="300" alt="TabBar" src="https://user-images.githubusercontent.com/25205138/96018081-c8f6f880-0e85-11eb-8689-4be3e16be038.png">



When using NeumorphismTabBarController, implement the inherited class.

```
import NeumorphismKit
import UIKit

class YourTabBarController: NeumorphismTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nskDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // If it is an empty string, the title will be hidden.
        let btn1 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "your_tab_img1")!)
        let btn2 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "your_tab_img2")!)
        let btn3 = NeumorphismTabBarItem(title: "", icon: UIImage(named: "your_tab_img3")!)
        let btn4 = NeumorphismTabBarItem(title: "Timeline", icon: UIImage(named: "your_tab_img4")!)
        let btn5 = NeumorphismTabBarItem(title: "Users", icon: UIImage(named: "your_tab_img5")!)

        // Set tuples for viewController and NeumorphismTabBarItem.
        self.setup(viewControllers: [
            (viewController: MainViewController.instantiate(), tabBarItem: btn1),
            (viewController: OtherViewController.instantiate(text: "View1"), tabBarItem: btn2),
            (viewController: OtherViewController.instantiate(text: "View2"), tabBarItem: btn3),
            (viewController: OtherViewController.instantiate(text: "View3"), tabBarItem: btn4),
            (viewController: OtherViewController.instantiate(text: "View4"), tabBarItem: btn5),
        ])
    }
}

extension YourTabBarController: NeumorphismTabBarControllerDelegate {

    // Delegate when switching tabs.
    func finishedSwitchingTab(fromIndex: Int, toIndex: Int) {
        print("fromIndex: \(fromIndex) toIndex: \(toIndex)")
    }
}

```



Then set YourTabBarController on the storyboard.



Other components can be used as well.
See [Demo project](https://github.com/y-okudera/NeumorphismKit/blob/master/Demo).

## Author

Yuki Okudera, appledev.yuoku@gmail.com

## License

NeumorphismKit is available under the MIT license. See the [LICENSE file](https://github.com/y-okudera/NeumorphismKit/blob/master/LICENSE) for more info.
