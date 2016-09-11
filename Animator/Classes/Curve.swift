//
//  Curve.swift
//  Pods
//
//  Created by Tomoya Hirano on 2016/09/11.
//
//

import UIKit

public class Curve {
  public typealias Calculator = ((x: Double)-> CGFloat)
  private var calc:Calculator
  public init(calc: Calculator) {
    self.calc = calc
  }
  
  internal func calc(x: Double) -> CGFloat {
    return calc(x: x)
  }
}

public extension Curve {
  public static func linear() -> Curve {
    return Curve(calc: { x in return CGFloat(x) })
  }
  
  public static func easeIn() -> Curve {
    return Curve(calc: { (x) -> CGFloat in
      return CGFloat(1.0 * pow(x, 2.0))
    })
  }
  
  public static func easeOut() -> Curve {
    return Curve(calc: { (x) -> CGFloat in
      return CGFloat(1.0 - pow(1.0 - x, 2.0))
    })
  }
}