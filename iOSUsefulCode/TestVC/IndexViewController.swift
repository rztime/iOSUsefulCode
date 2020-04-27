//
//  IndexViewController.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/24.
//  Copyright © 2020 rztime. All rights reserved.
//

import UIKit

class testLabel: UILabel {
    deinit {
        print(" testLabel \(#function)")
    }
}

class IndexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let label = testLabel.init()
        label.text = "哈哈哈哈哈哈哈哈或或或或或或"
        self.view.addSubview(label)
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 20)
        label.rzCircular(20, [.topLeft, .bottomRight])
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
        label.backgroundColor = RZColor("#FF0000")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        print("IndexViewController \(#function)")
    }

}
