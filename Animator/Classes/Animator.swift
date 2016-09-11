//
//  Animator.swift
//  Pods
//
//  Created by Tomoya Hirano on 2016/09/11.
//
//

import UIKit

public final class Animator {
  private var duration = 10.0
  private var currentTime  = 0.0
  private var frameRate = 1.0 / 30.0
  private var timer: NSTimer? = nil
  private var curve: Curve
  private var animations: ((value: Double)->Void)? = nil
  private var completion: (()->Void)? = nil
  
  public init(duration: NSTimeInterval, frameRate: Double = 1.0 / 30.0, curve: Curve = Curve.linear(), animations: ((value: Double) -> Void), completion: (() -> Void)? = nil) {
    self.duration = duration
    self.frameRate = frameRate
    self.animations = animations
    self.completion = completion
    self.curve = curve
  }
  
  public func resume() {
    timer?.invalidate()
    timer = nil
    currentTime = 0
    timer = NSTimer.scheduledTimerWithTimeInterval(frameRate, target: self, selector: #selector(Animator.update), userInfo: nil, repeats: true)
  }
  
  @objc private func update() {
    let x = currentTime / duration
    let currentValue = curve.calc(x)
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.animations?(value: currentValue)
    }
    currentTime += frameRate
    if (currentTime >= duration) {
      timer?.invalidate()
      timer = nil
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
        self.completion?()
      }
    }
  }
}