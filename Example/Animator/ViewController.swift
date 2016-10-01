//
//  ViewController.swift
//  Animator
//
//  Created by Tomoya Hirano on 09/11/2016.
//  Copyright (c) 2016 Tomoya Hirano. All rights reserved.
//

import UIKit
import Animator

class ViewController: UIViewController {

  fileprivate let v0 = UIView.createDummyView(UIColor.red)
  fileprivate let v1 = UIView.createDummyView(UIColor.blue)
  fileprivate let v2 = UIView.createDummyView(UIColor.green)
  fileprivate let v3 = UIView.createDummyView(UIColor.yellow)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(v0)
    view.addSubview(v1)
    view.addSubview(v2)
    view.addSubview(v3)
    
    v0.center = CGPoint(x: 0, y: 100)
    v1.center = CGPoint(x: 0, y: 200)
    v2.center = CGPoint(x: 0, y: 300)
    v3.center = CGPoint(x: 0, y: 400)
  }
  
  @IBAction func startAction(_ sender: AnyObject) {
    Animator(duration: 1.0, frameRate: 30, curve: Curve.linear(), animations: { (value) in
      self.v0.center = CGPoint(x: self.view.bounds.width * value, y: 100)
    }).resume()
    Animator(duration: 1.0, frameRate: 45, curve: Curve.easeIn(), animations: { (value) in
      self.v1.center = CGPoint(x: self.view.bounds.width * value, y: 200)
    }).resume()
    Animator(duration: 1.0, frameRate: 60, curve: Curve.easeOut(), animations: { (value) in
      self.v2.center = CGPoint(x: self.view.bounds.width * value, y: 300)
    }).resume()
    
    let curve = Curve { (x) -> CGFloat in
      return CGFloat(sin(x * 4.0))
    }
    Animator(duration: 1.0, frameRate: 60, curve: curve, animations: { (value) in
      self.v3.center = CGPoint(x: self.view.bounds.width * value, y: 400)
    }).resume()
  }
}

extension UIView {
  static func createDummyView(_ color: UIColor) -> UIView {
    let v = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    v.backgroundColor = color
    return v
  }
}

