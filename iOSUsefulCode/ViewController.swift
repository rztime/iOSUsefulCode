//
//  ViewController.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/24.
//  Copyright © 2020 rztime. All rights reserved.
//

import UIKit
import AVFoundation
@_exported import RxSwift
@_exported import RZColorfulSwift
@_exported import Then

struct xxxxxxxxname {
    
}

class ViewController: UIViewController {
    let tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
    
    let dataSource:[[String:Any]] = [
        ["vc":IndexViewController.self, "des":"test"], 
        ["vc":UISegmentTestViewController.self, "des":"segment控件"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.frame = RZCGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 88 - 34)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = RZColorCreat(defColor:UIColor.white, darkColor: UIColor.red)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
            cell?.textLabel?.rzTap {
                print("点击了tap")
            }
        }
        cell?.textLabel?.text = item["des"] as? String
        let cls = item["vc"] as? UIViewController.Type
        
        let name = RZStringFormAny(cls.self)
        
        cell?.detailTextLabel?.text = name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        let cla : UIViewController.Type = item["vc"] as! UIViewController.Type
        self.navigationController?.pushViewController(cla.init(), animated: true)
    }
}
