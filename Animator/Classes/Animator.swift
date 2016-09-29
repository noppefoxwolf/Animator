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
  private var frameRate = 30.0
  private var timer: Timer? = nil
  private var curve: Curve
  private var animations: ((_ value: CGFloat)->Void)? = nil
  private var completion: (()->Void)? = nil
  
  public init(duration: TimeInterval, frameRate: Double = 1.0 / 30.0, curve: Curve = Curve.linear(), animations: @escaping ((_ value: CGFloat) -> Void), completion: (() -> Void)? = nil) {
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
    timer = Timer.scheduledTimer(timeInterval: 1.0 / frameRate, target: self, selector: #selector(Animator.update), userInfo: nil, repeats: true)
  }
  
  @objc private func update() {
    let x = currentTime / duration
    let currentValue = curve.calc(x)
    DispatchQueue.main.async { [weak self] () -> Void in
      self?.animations?(currentValue)
    }
    currentTime += (1.0 / frameRate)
    if (currentTime >= duration) {
      timer?.invalidate()
      timer = nil
      DispatchQueue.main.async { () -> Void in
        self.completion?()
      }
    }
  }
}
