# SJFluidSegmentedControl

[![Version](https://img.shields.io/cocoapods/v/SJFluidSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/SJFluidSegmentedControl)
[![Downloads](https://img.shields.io/cocoapods/dt/SJFluidSegmentedControl.svg?maxAge=2592000)](http://cocoapods.org/pods/SJFluidSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/SJFluidSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/SJFluidSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/SJFluidSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/SJFluidSegmentedControl)
[![Language](https://img.shields.io/badge/swift-3.0-green.svg?style=flat)](https://developer.apple.com/swift/)

## About

If you are bored with using the default `UISegmentedControl`, this might save your day. `SJFluidSegmentedControl` is a customizable segmented control with an interactive transition, written in Swift 3.0 and it is based on [LUNSegmentedControl](https://github.com/LunApps/LUNSegmentedControl) by [LunApps](https://lunapps.com) which is written in Objective-C.

![Sample](https://raw.githubusercontent.com/sasojadrovski/SJFluidSegmentedControl/master/Screenshots/sample.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+ 
- Xcode 8.0+
- Swift 3.0+

**Note:** `SJFluidSegmentedControl` is not intended to be used from Objective-C. For an Objective-C version of this library, please refer to the [LUNSegmentedControl](https://github.com/LunApps/LUNSegmentedControl).

## Features

- [x] Easy to setup and use
- [x] Lots of customizable options
- [x] [Complete Documentation](http://cocoadocs.org/docsets/SJFluidSegmentedControl)

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Apps using this library

- [Uread](https://itunes.apple.com/us/app/you-duuread-zhi-gei-xiang/id1175225244) for iPhone/iPad by [@Jinkeycode](https://github.com/Jinkeycode) ([Preview](https://cloud.githubusercontent.com/assets/12148377/21546445/c55b05f0-ce19-11e6-9d28-1fc2febe20fd.jpeg))

> If your app is using this library, I would love to add it to this README. Please reach out to me!

## Installation

#### [CocoaPods](https://cocoapods.org/)

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build SJFluidSegmentedControl 1.0.0+.

To integrate `SJFluidSegmentedControl` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SJFluidSegmentedControl', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

#### Manual installation

`SJFluidSegmentedControl` can also be installed manually by simply dragging and dropping the files located in the Classes folder.

## Usage

#### Using Interface Builder

1. Drag &amp; drop a UIView in the View.
	- By setting the background color of this view, you will also be setting the background color of the segmented control.
2. Change its class to SJFluidSegmentedControl.
3. Connect its data source.
4. Implement the only required data source method that returns the number of segments in the segmented control:

```swift
func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int
```

Additionaly, you can set the `cornerRadius`, `textColor`, `selectedSegmentTextColor`, `selectorViewColor`, `applyCornerRadiusToSelectorView`, `gradientBounceColor`, `shadowShowDuration`, `shadowHideDuration` and `shadowsEnabled` properties by using the Attributes inspector.

![Attributes](https://raw.githubusercontent.com/sasojadrovski/SJFluidSegmentedControl/master/Screenshots/attributes.png)

For customizing other of the available properties, create an `@IBOutlet` of the segmented control and access them via code.

#### Using Code

It's very similar to using Interface Builder, instead you just setup the custom view in code. There are several methods to do this, here's an example:

```swift
// Conform to the data source (optionally, you can conform to the delegate)
class ViewController: UIViewController, SJFluidSegmentedControlDataSource {

	// Define a lazy var
	lazy var segmentedControl: SJFluidSegmentedControl = {
	    [unowned self] in
	    // Setup the frame per your needs
	    let segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
	    segmentedControl.dataSource = self
	    return segmentedControl
	}()

	// Add it as a subview in viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(segmentedControl)
	}

	// Don't forget to implement the required data source method
	func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
		return 3
	}

}
```

#### Data Source Implementation

You must implement the **required** data source method that returns the number of segments:

```swift
func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int
```

Return the titles for the segments of the segmented control, and take advantage of the NSAttributedString features to customize the text appearance using the following data source methods:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     titleForSegmentAtIndex index: Int) -> String?
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     attributedTitleForSegmentAtIndex index: Int) -> NSAttributedString?
```

If necessary, you can set the titles for the selected state of the segments with the help of the following data source methods:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     titleForSelectedSegmentAtIndex index: Int) -> String?
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     attributedTitleForSelectedSegmentAtIndex index: Int) -> NSAttributedString?
```

You can also set the title color for the selected state of the segments using this data source method:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     titleColorForSelectedSegmentAtIndex index: Int) -> UIColor
```

In addition, you can set a color (or an array of colors to form a gradient) for each segment, as well as colors for the left and right bounces with the help of the following data source methods:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor]
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor]
```

If you need a more complex layout for each segment, you can return a custom view instead with these data source methods:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     viewForSegmentAtIndex index: Int) -> UIView
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     viewForSelectedSegmentAtIndex index: Int) -> UIView

```

#### Delegate Implementation

The delegate methods provide callbacks for some of the most commonly needed events, such as:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     didChangeFromSegmentAtIndex fromIndex: Int,
                                     toSegmentAtIndex toIndex:Int)
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     willChangeFromSegment fromSegment: Int)
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     didScrollWithXOffset offset: CGFloat)

```

Additionaly, if you need to take control over the transitions between the segments, you can use the following delegate methods:

```swift
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     setupSegmentAtIndex segmentIndex: Int,
                                     unselectedView unselectedSegmentView: UIView,
                                     selectedView selectedSegmentView: UIView,
                                     withSelectionPercent percent: CGFloat)
@objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                     resetSegmentAtIndex segmentIndex: Int,
                                     unselectedView unselectedSegmentView: UIView,
                                     selectedView selectedSegmentView: UIView)
```

#### Additional properties

Other customization options are available through the following publicly available properties:

```swift
// The index of the currently selected segment. It ranges from 0 to segmentsCount-1. Default is `0`.
open var currentSegment: Int

// The number of segments in the segmented control. Default is `1`.
fileprivate(set) public var segmentsCount: Int

// The transition style between the default and selected state of the segments. Default is `.fade`.
open var transitionStyle: SJFluidSegmentedControlTransitionStyle

// The style of the selecton shape. Default is `.liquid`.
open var shapeStyle: SJFluidSegmentedControlShapeStyle

// The corner radius of the segmented control. Default is `0.0`.
@IBInspectable open var cornerRadius: CGFloat

// The color of the text for the default state of a segment. Default is `.black`. This property will be overriden if the delegate for attributed titles/views is implemented.
@IBInspectable open var textColor: UIColor

// The color of the text for the selected state of a segment. Default is `.white`. This property will be overriden if the delegate for attributed titles for selected state or views for selected state is implemented.
@IBInspectable open var selectedSegmentTextColor: UIColor

// The text font for the titles of the segmented control in both states if the data source does not provide attributed titles or views. Default is `.systemFont(ofSize: 14)`.
open var textFont: UIFont

// The color of the selector. Default is `.clear`. **Note:** If set, it is overlayed over the gradient colors.
@IBInspectable open var selectorViewColor: UIColor

// A boolean value to determine whether the selector should have rounded corners. Default is `false`.
@IBInspectable open var applyCornerRadiusToSelectorView: Bool

// The color for the bounce if the data source does not provide colors for bounces. Default is `.red`.
@IBInspectable open var gradientBounceColor: UIColor

// The duration of the show shadow animation. Default is `0.5`.
@IBInspectable open var shadowShowDuration: CGFloat

// The duration of the hide shadow animation. Default is `0.8`.
@IBInspectable open var shadowHideDuration: CGFloat

// A boolean value to determine whether shadows should be applied. Default is `true`.
@IBInspectable open var shadowsEnabled: Bool
```

#### Reload data

If you need to reload the data of the segmented control, simply call:

```swift
segmentedControl.reloadData()
```

## Author

This library has been adapted for Swift 3.0+ by **Sasho Jadrovski**, [http://jadrovski.com](http://jadrovski.com). The original creators are [LunApps](https://lunapps.com), as stated above.

## License

`SJFluidSegmentedControl` is available under the MIT license. See the LICENSE file for more info.
