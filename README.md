# Animator

[![CI Status](http://img.shields.io/travis/Tomoya Hirano/Animator.svg?style=flat)](https://travis-ci.org/Tomoya Hirano/Animator)
[![Version](https://img.shields.io/cocoapods/v/Animator.svg?style=flat)](http://cocoapods.org/pods/Animator)
[![License](https://img.shields.io/cocoapods/l/Animator.svg?style=flat)](http://cocoapods.org/pods/Animator)
[![Platform](https://img.shields.io/cocoapods/p/Animator.svg?style=flat)](http://cocoapods.org/pods/Animator)


![](https://raw.githubusercontent.com/noppefoxwolf/Animator/master/Example/sample.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#Usage

```
Animator(duration: 1.0, frameRate: 30.0, curve: Curve.easeOut(), animations: { (value) in
  self.v.center = CGPoint(x: self.view.bounds.width * value, y: 300)
}).resume()
```

## create curve

```
Curve(calc: { (x) -> CGFloat in
      return CGFloat(1.0 - pow(1.0 - x, 2.0))
})
```
x is 0.0 to 1.0.


## Requirements

## Installation

Animator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Animator"
```

## Author

Tomoya Hirano, tomoya.hirano@dena.com

## License

Animator is available under the MIT license. See the LICENSE file for more info.
