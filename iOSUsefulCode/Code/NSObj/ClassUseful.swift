//
//  StringUseful.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/24.
//  Copyright © 2020 rztime. All rights reserved.
//

import Foundation
import UIKit

func RZClassFromString(_ clsName:String) -> AnyClass {
    let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    return NSClassFromString(namespace + "." + clsName)!
}

func RZStringFormAny<T>(_ any:T) -> String {
    var string = "\(any)"
    if string .hasPrefix("Optional(") {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let temp = "Optional(" + namespace + "."
        string = string.replacingOccurrences(of: temp, with: "")
                        .replacingOccurrences(of: ")", with: "")
    }
    return string
}

func RZCGSizeMake(_ width:CGFloat, _ height:CGFloat) -> CGSize {
    return CGSize.init(width: width, height: height)
}
func RZCGRectMake(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> CGRect {
    return CGRect.init(x: x, y: y, width: width, height: height)
}
func RZCGPointMake(_ x:CGFloat, _ y:CGFloat) -> CGPoint {
    return CGPoint.init(x: x, y: y)
}

func RZColor(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RZColor(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor {
    return RZColor(r, g, b, 1)
}
func RZColor(_ OxHex:UInt32, _ alpha : CGFloat = 1) -> UIColor {
    let r = CGFloat((OxHex & 0xFF0000) >> 16)
    let g = CGFloat((OxHex & 0xFF00) >> 8)
    let b = CGFloat(OxHex & 0xFF)
    return RZColor(r, g, b, alpha)
}
func RZColor(_ hex:String, _ alpha : CGFloat = 1) -> UIColor {
    guard hex.count >= 6 else {
        return UIColor.clear
    }
    var tempHex = hex.uppercased()
    if tempHex.hasPrefix("##") || tempHex.hasPrefix("0x") || tempHex.hasPrefix("0X") {
        tempHex = String(tempHex.dropFirst(2))
    }
    if tempHex.hasPrefix("#") {
        tempHex = String(tempHex.dropFirst())
    }
    var oxHex : UInt32 = 0
    Scanner.init(string: tempHex).scanHexInt32(&oxHex)
    return RZColor(oxHex, alpha)
}

enum RZUserInterfaceStyle {
    case unspecified
    case light
    case dark
}

func RZColorCreat(_ style:RZUserInterfaceStyle = .unspecified,  defColor:UIColor?, darkColor:UIColor?) -> UIColor {
    switch style {
    case .light:
        return defColor ?? UIColor.clear
    case .dark:
        return darkColor ?? UIColor.clear
    case .unspecified:
        if #available(iOS 13.0, *) {
            return UIColor.init { (trai) -> UIColor in
                if trai.userInterfaceStyle == .dark {
                    return darkColor ?? UIColor.clear
                }
                return defColor ?? UIColor.clear
            }
        } else {
            return defColor ?? UIColor.clear
        }
    }
}
