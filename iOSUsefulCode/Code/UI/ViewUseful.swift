//
//  ViewUseful.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/25.
//  Copyright © 2020 rztime. All rights reserved.
//

import Foundation
import UIKit

public struct RZViewAnimationType : OptionSet {
    public let rawValue: Int
    public init(rawValue:Int) {
        self.rawValue = rawValue
    }
    /// 无
    public static let none  = RZViewAnimationType(rawValue: 1 << 0)
    /// 左
    public static let left  = RZViewAnimationType(rawValue: 1 << 1)
    /// 右
    public static let right = RZViewAnimationType(rawValue: 1 << 2)
    /// 上
    public static let top   = RZViewAnimationType(rawValue: 1 << 3)
    /// 下
    public static let bottom = RZViewAnimationType(rawValue: 1 << 4)
}

//MARK:裁剪圆角
public extension UIView {
    /// 裁剪圆角             view.rzCircular(radius: 10, locations:[.topLeft, .bottomRight])
    /// - Parameters:
    ///   - radius: 半径
    ///   - locations: 位置 all，四个角
    func rzCircular(_ radius:CGFloat, _ locations:UIRectCorner) {
        RZGCD.after(timer: 0.1) {
            let maskBezier = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: locations, cornerRadii: RZCGSizeMake(radius, radius))
            let maskLayer = CAShapeLayer.init()
            maskLayer.frame = self.bounds
            maskLayer.path = maskBezier.cgPath
            self.layer.mask = maskLayer
        }
    }
}

public extension UIView {
    /// 显示动画
    /// - Parameters:
    ///   - timer: 过程时长
    ///   - animations: 动画类型
    func rzDisplayAnimation(_ timer: TimeInterval, _ animations: [RZViewAnimationType], _ complete:(()->Void)? = nil) {
        if animations.contains(.none) {
            complete?()
            return
        }
        let alpha = self.alpha
        self.alpha = 0
        RZGCD.after(timer: 0.1) {
            let sWidth = UIScreen.main.bounds.size.width
            let sHeight = UIScreen.main.bounds.size.height
          
            let rect = self.convert(self.bounds, to: UIApplication.shared.keyWindow)
            
            let endCenter = CGPoint.init(x: rect.origin.x + self.frame.width / 2.0, y:  rect.origin.y + self.frame.height / 2.0)
            var starCenter = endCenter
            
            if animations.contains(.left) {
                starCenter.x =  -(self.bounds.size.width / 2.0)
            }
            if animations.contains(.right) {
                starCenter.x = sWidth + (self.bounds.size.width / 2.0)
            }
            if animations.contains(.top) {
                starCenter.y = -(self.bounds.size.height / 2.0)
            }
            if animations.contains(.bottom) {
                starCenter.y = sHeight + (self.bounds.size.height / 2.0)
            }
            self.alpha = alpha
            let tempView = UIImageView.init(image: self.rzCovertToImage())
            self.alpha = 0
            tempView.alpha = 0.3
            tempView.center = starCenter
            UIApplication.shared.keyWindow?.addSubview(tempView)
            UIView.animate(withDuration: TimeInterval(timer), delay: 0, options: .curveEaseOut, animations: {
                tempView.center = endCenter
                tempView.alpha = 1
            }) { (_) in
                self.alpha = alpha
                tempView.removeFromSuperview()
                complete?()
            }
        }
    }
    
    /// 隐藏动画
    func rzHiddenAnimation(_ timer: TimeInterval, _ animations: [RZViewAnimationType], _ complete:(()->Void)? = nil) {
        if animations.contains(.none) {
            self.isHidden = true
            complete?()
            return
        }
        RZGCD.after(timer: 0.1) {
            let sWidth = UIScreen.main.bounds.size.width
            let sHeight = UIScreen.main.bounds.size.height
            
            let rect = self.convert(self.bounds, to: UIApplication.shared.keyWindow)
            
            var endCenter = CGPoint.init(x: rect.origin.x + self.frame.width / 2.0, y:  rect.origin.y + self.frame.height / 2.0)
            let starCenter = endCenter
             
            if animations.contains(.left) {
                endCenter.x =  -(self.bounds.size.width / 2.0)
            }
            if animations.contains(.right) {
                endCenter.x = sWidth + (self.bounds.size.width / 2.0)
            }
            if animations.contains(.top) {
                endCenter.y = -(self.bounds.size.height / 2.0)
            }
            if animations.contains(.bottom) {
                endCenter.y = sHeight + (self.bounds.size.height / 2.0)
            }
            let tempView = UIImageView.init(image: self.rzCovertToImage())
            self.isHidden = true
            tempView.center = starCenter
            UIApplication.shared.keyWindow?.addSubview(tempView)
            UIView.animate(withDuration: TimeInterval(timer), delay: 0, options: .curveEaseOut, animations: {
                tempView.center = endCenter
                tempView.alpha = 0.3
            }) { (_) in
                tempView.removeFromSuperview()
                complete?()
            }
        }
    }
    /// 抖动
    /// - Parameters:
    ///   - timer: 抖动一个周期时间
    ///   - value: 抖动弧度
    ///   - repeatCount:重复次数
    func rzShake(_ timer:TimeInterval, _ value:Double, _ repeatCount:Float = MAXFLOAT) {
        let animation = CAKeyframeAnimation.init()
        animation.keyPath = "transform.rotation"
        let r = (value / 180.0 * .pi)
        animation.values = [0, r, 0, -r, 0]
        animation.duration = timer
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = true
        animation.fillMode = .removed
        self.layer.add(animation, forKey: "rzview.animation.shake")
    }
    /// 将view 转成图片
    func rzCovertToImage() -> UIImage {
        var image = UIImage()
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func addSubviews(_ views :[UIView]) {
        views.forEach { (v) in
            self.addSubview(v)
        }
    }
}
//MARK:处理耗时任务
public extension UIView {
    /// 处理动画耗时任务
    /// - Parameters:
    ///   - task: 耗时任务
    ///   - t: 之后
    ///  如在UITableview  中delete 或 insert cell之后，需要reloaddata，但是又要必须在delete或insert动画完成之后才能reload，
    ///  可以在task中delete 或insert cell， 在then中reloaddata
    static func rzHandleTask(_ task:(() -> Void)?, then t:(() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            t?()
        }
        task?()
        CATransaction.commit()
    }
}
public extension UIView {
    fileprivate struct UIViewPerpotyName {
        static var rztaphandlerKey = "rztaphandler"
    }
    
    fileprivate var rztaphandler :(() -> Void)? {
        set {
            objc_setAssociatedObject(self, &UIViewPerpotyName.rztaphandlerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let handler = objc_getAssociatedObject(self, &UIViewPerpotyName.rztaphandlerKey) {
                return handler as? (() -> Void)
            }
            return nil
        }
    }
    
    func rzTap(_ handler:@escaping (() -> Void)) {
        self.rzTap(1, 1, handler)
    }
    
    func rzTap(_ numberOfTouches: Int, _ numberOfTaps:Int, _ handler:@escaping (() -> Void)) {
        let tapges = UITapGestureRecognizer()
        tapges.numberOfTouchesRequired = numberOfTouches
        tapges.numberOfTapsRequired = numberOfTaps
        self.gestureRecognizers?.forEach({ (obj) in
            let tap = obj as! UITapGestureRecognizer
            let touches = tap.numberOfTouchesRequired == numberOfTouches
            let taps = tap.numberOfTapsRequired == numberOfTaps
            if touches && taps {
                tapges.require(toFail: tap)
            }
        })
        tapges.addTarget(self, action: #selector(rzTapAction(_:)))
        self.addGestureRecognizer(tapges)
        self.rztaphandler = handler
        self.isUserInteractionEnabled = true
    }
    @objc fileprivate func rzTapAction(_ tap:UITapGestureRecognizer) {
        if tap.state == .ended {
            self.rztaphandler?()
        }
    }
}
