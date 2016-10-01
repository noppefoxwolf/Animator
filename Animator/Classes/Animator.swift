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
  private var frameRate: Int = 30
  private var linker: CADisplayLink? = nil
  private var curve: Curve
  private var animations: ((_ value: CGFloat)->Void)? = nil
  private var completion: (()->Void)? = nil
  
  public init(duration: TimeInterval, frameRate: Int = 30, curve: Curve = Curve.linear(), animations: @escaping ((_ value: CGFloat) -> Void), completion: (() -> Void)? = nil) {
    self.duration = duration
    self.frameRate = frameRate
    self.animations = animations
    self.completion = completion
    self.curve = curve
  }
  
  public func resume() {
    linker?.remove(from: .current, forMode: .commonModes)
    linker?.invalidate()
    linker = nil
    currentTime = 0
    
    linker = CADisplayLink(target: self, selector: #selector(Animator.update))
    linker?.preferredFramesPerSecond = frameRate
    linker?.add(to: .current, forMode: RunLoopMode.commonModes)
  }
  
  @objc private func update() {
    let x = currentTime / duration
    let currentValue = curve.calc(x)
    DispatchQueue.main.async { [weak self] () -> Void in
      self?.animations?(currentValue)
    }
    currentTime += (1.0 / Double(frameRate))
    if (currentTime >= duration) {
      linker?.remove(from: .current, forMode: .commonModes)
      linker?.invalidate()
      linker = nil
      DispatchQueue.main.async { () -> Void in
        self.completion?()
      }
    }
  }
}
