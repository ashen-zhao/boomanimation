//
//  ViewController.swift
//  Animation
//
//  Created by ashen on 2017/11/22.
//  Copyright © 2017年 Uubee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var bigView: UIImageView!
    var square:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animation_bigImage()
        animation_shadow()
        
        
        let square1 = drawSquare(UIColor.blue, size: 5)
        self.animation_smallImage(square1, points: [-20,-70,
                                                   -80,-100,
                                                   -40,-90])
        
        
        let color1 = drawCycle(UIColor.purple, size: 9)
        self.animation_smallImage(color1, points: [-20,-70,
                                                   -70,-150,
                                                   -40,-130])
        
        
        let image1 = UIImageView(image: UIImage(named: "s"))
        self.view.addSubview(image1)
        self.animation_smallImage(image1, points: [-20,-90,
                                                   -60,-170,
                                                   -40,-150])
        
        let color2 = drawCycle(UIColor.orange, size: 10)
        self.animation_smallImage(color2, points: [-10,-90,
                                                   -40,-180,
                                                   -20,-150])
        
        let color3 = drawCycle(UIColor.red, size: 8)
        self.animation_smallImage(color3, points: [0,-120,
                                                   0,-210,
                                                   0,-140])
        
        let color4 = drawCycle(UIColor.blue, size: 6)
        self.animation_smallImage(color4, points: [10,-110,
                                                   40,-190,
                                                   30,-140])
       
        let image2 = UIImageView(image: UIImage(named: "s"))
        self.view.addSubview(image2)
        self.animation_smallImage(image2, points: [20,-90,
                                                   60,-170,
                                                   40,-140])
        
        let image3 = UIImageView(image: UIImage(named: "s"))
        self.view.addSubview(image3)
        self.animation_smallImage(image3, points: [15,-100,
                                                   80,-150,
                                                   50,-120])
        
        let square2 = drawSquare(UIColor.orange, size: 5)
        self.animation_smallImage(square2, points: [20,-70,
                                                    80,-120,
                                                    40,-90])
        
        
        let square3 = drawSquare(UIColor.red, size: 5)
        self.animation_smallImage(square3, points: [20,-60,
                                                    80,-90,
                                                    40,-80])
       
    }
    
    func drawCycle(_ color:UIColor, size:CGFloat) -> UIImageView {
        let color1 = UIImageView(image: imageWithColor(color))
        color1.frame = CGRect.init(x: 0, y: 0, width: size, height: size)
        color1.layer.cornerRadius = size/2
        color1.layer.masksToBounds = true
        let temp1 = UIView(frame: CGRect.init(x: 0, y: 0, width: size - 2, height: size - 2))
        temp1.layer.cornerRadius = (size - 2)/2
        temp1.layer.masksToBounds = true
        temp1.center = color1.center
        temp1.backgroundColor = UIColor(hex:"F7F7F7")
        color1.addSubview(temp1)
        self.view.addSubview(color1)
        return color1
    }
    
    func drawSquare(_ color:UIColor, size:CGFloat) -> UIImageView {
        let square = UIImageView(image: imageWithColor(color))
        square.frame = CGRect.init(x: 0, y: 0, width: size, height: size)
        self.view.addSubview(square)
        return square
    }
    
    
    func animation_smallImage(_ imgv:UIImageView, points:Array<CGFloat>) {
        
        let bigcenter = self.bigView.center
        let path1 = UIBezierPath()
        path1.move(to: CGPoint.init(x: bigcenter.x + points[0], y: bigcenter.y + points[1]))
        path1.addCurve(to: CGPoint(x: bigcenter.x + points[2], y: bigcenter.y + points[3]),
                       controlPoint1: CGPoint(x: bigcenter.x + points[4], y: bigcenter.y + points[5]),
                       controlPoint2: CGPoint(x: bigcenter.x + points[2], y: bigcenter.y + points[3]))
        
        let animationGroup = CAAnimationGroup()
        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.beginTime = CACurrentMediaTime()
        animationGroup.duration = 1.4
        animationGroup.repeatCount = HUGE
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animationGroup.isRemovedOnCompletion = false
        
        let positionAnimation = CAKeyframeAnimation(keyPath:"position")
        positionAnimation.path = path1.cgPath
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [1.0, 1.5, 1.0, 0.0]
        opacityAnimation.keyTimes = [0.0, 0.4, 0.8, 1.0]
        opacityAnimation.isRemovedOnCompletion = false
        
        animationGroup.animations = [positionAnimation, opacityAnimation]
        
        imgv.layer.add(animationGroup, forKey: "pulsing")
        
    }
    
    
    func animation_bigImage() {
        
        let animationGroup1 = CAAnimationGroup()
        animationGroup1.duration = 0.7
        animationGroup1.repeatCount = HUGE
        animationGroup1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animationGroup1.autoreverses = true
        animationGroup1.isRemovedOnCompletion = false
        
        let path11 = UIBezierPath()
        path11.move(to: self.bigView.center)
        path11.addCurve(to: CGPoint(x: self.bigView.center.x, y: self.bigView.center.y - 110),
                        controlPoint1: CGPoint(x: self.bigView.center.x, y: self.bigView.center.y - 60),
                        controlPoint2: CGPoint(x: self.bigView.center.x, y: self.bigView.center.y - 110))
        
        let positionAnimation1 = CAKeyframeAnimation(keyPath:"position")
        positionAnimation1.path = path11.cgPath
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAnimation.fromValue = 0.7
        scaleAnimation.toValue = 1.0
        scaleAnimation.duration = 0.3
        
        animationGroup1.animations = [positionAnimation1,scaleAnimation]
        self.bigView.layer.add(animationGroup1, forKey: "movebig")
        
        
    }
    
    func animation_shadow() {
        
        self.bgview.layer.cornerRadius = 25
        
        
        let animationGroupbg = CAAnimationGroup()
        animationGroupbg.duration = 0.7
        animationGroupbg.repeatCount = HUGE
        animationGroupbg.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animationGroupbg.autoreverses = true
        animationGroupbg.isRemovedOnCompletion = false
        
        let scaleAnimationbg = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAnimationbg.fromValue = 0.3
        scaleAnimationbg.toValue = 0.15
        
        let scaleAnimationbgx = CABasicAnimation(keyPath: "transform.scale.x")
        scaleAnimationbgx.fromValue = 1.2
        scaleAnimationbgx.toValue = 0.6
        
        animationGroupbg.animations = [scaleAnimationbg,scaleAnimationbgx]
        
        self.bgview.layer.add(animationGroupbg, forKey: "bgviewmove")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageWithColor(_ color: UIColor) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}

extension UIColor {
    public convenience init(hex: String, alpha: CGFloat) {
        
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        var value: UInt32 = 0
        
        Scanner(string: cString).scanHexInt32(&value)
        
        if (cString.lengthOfBytes(using: String.Encoding.utf8) == 8) {
            self.init(red: CGFloat((value & 0xFF000000) >> 24) / 255.0,
                      green: CGFloat((value & 0x00FF0000) >> 16) / 255.0,
                      blue: CGFloat((value & 0x0000FF00) >> 8) / 255.0,
                      alpha: CGFloat((value & 0x000000FF)) / 255.0)
        }
        else{
            self.init(red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(value & 0x0000FF) / 255.0,
                      alpha: 1.0)
        }
    }
    
    public convenience init(hex: String){
        self.init(hex: hex, alpha: 1)
    }
}
