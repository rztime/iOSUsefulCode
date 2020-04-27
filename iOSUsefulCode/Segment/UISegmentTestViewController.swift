//
//  UISegmentTestViewController.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/4/26.
//  Copyright © 2020 rztime. All rights reserved.
//

import UIKit

class UISegmentTestViewController: UIViewController {
    var segmentView : CMSegmentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentView = CMSegmentView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.bounds.size.width, height: 44))
        self.view.addSubview(segmentView!)

        let attr = NSAttributedString.rz_colorfulConfer { (confer) in
            confer.text("高级")?.textColor(.gray).font(.systemFont(ofSize: 15))
            confer.image(UIImage.init(named: "img"))?.size(.init(width: 15, height: 15), align: .center, font: .systemFont(ofSize: 15))
            confer.text("用法")?.textColor(.gray).font(.systemFont(ofSize: 15))
        }
        let hightAttr = NSAttributedString.rz_colorfulConfer { (confer) in
            confer.text("高级")?.textColor(.black).font(.systemFont(ofSize: 17))
            confer.image(UIImage.init(named: "img"))?.size(.init(width: 17, height: 17), align: .center, font: .systemFont(ofSize: 17))
            confer.text("用法")?.textColor(.black).font(.systemFont(ofSize: 17))
        }
        // 标题
        segmentView?.items = [
            .init(text: "标题1标题", badge: "1"),
            .init(attributedText: attr, hightLightAttributedText: hightAttr), // 富文本用法
            .init(text: "标题2"),
            .init(text: "标题3"),
            .init(text: "标题4"),
            .init(text: "标题5"),
        ]
// 默认配置，未选中的状态，
//        segmentView?.itemConfigure = .init(font: .systemFont(ofSize: 14), textColor: .gray, badgeFont: .systemFont(ofSize: 11), badgeTextColor: .white, badgeBgColor: .red, bgColor: .clear)
// 选中的状态
//        segmentView?.itemHightLightConfigure = .init(font: .systemFont(ofSize: 16), textColor: .black, badgeFont: .systemFont(ofSize: 11), badgeTextColor: .white, badgeBgColor: .red, bgColor: .clear)
        
// 设置单个item的大小，可以三种设置方式 (默认 .auto)
//        segmentView?.segmentItemSize = .auto(leadingMargin: 15, height: 44)  // 1根据文本内容，设置左右间距，根据文字长度适配
        
// 底部线条  默认 .none 不显示
        segmentView?.bottomLineConfigure = .auto(leadingMargin: 15, height: 3, bottomMargin: 3, color: .red) // 自动根据文字长度适配

// 设置选中之后的背景框，属性也是可以自动、固定、等等，默认不显示
        segmentView?.itemBackgroundViewConfigure = .textEdge(edge: .init(top: 3, left: 10, bottom: 3, right: 10), radius: 5, color: .lightGray)
// 分割线 默认.none 不显示
//        segmentView?.separateLineConfigure = .lock(size: .init(width: 3, height: 30), radius: 1.5, color: .gray)
        
// 内容 较少时，view对齐方式 默认auto 居中
//                segmentView?.style = .top
// 滚动方式 水平、垂直
//                segmentView?.direction = .vertical
// 文字对齐方式 居左、居中、居右
        //        segmentView?.textAlign = .center

// 设置单个item的大小，可以三种设置方式  自动、固定、自定义  (默认 自动)
                //segmentView?.segmentItemSize = .lock(80, 44)  //2 固定长度
                // 根据 内容自定义适配
        //        segmentView?.segmentItemSize = .custom(value: { (view) -> CGSize in
        //            let index = view.selectedIndex
        //            let item = view.items[index]
        //            print(item.text)
        //            return CGSize.init(width: item.text?.count ?? 0 * 20 + 20, height: 20)
        //        })
                
                
// 底部线条 可以三种设置方式  自动、固定、自定义  不显示 默认 .none
        //        segmentView?.bottomLineConfigure = .none //  不显示
        //        segmentView?.bottomLineConfigure = .lock(30, 3, 3, .red) // 固定大小
        //        segmentView?.bottomLineConfigure = .custom(value: { (seg, cell, line) in // 自定义
        //
        //        })

// 分割线
//        segmentView?.separateLineConfigure = .none
//        segmentView?.separateLineConfigure = .lock(size: .init(width: 3, height: 30), radius: 1.5, color: .gray)
}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
