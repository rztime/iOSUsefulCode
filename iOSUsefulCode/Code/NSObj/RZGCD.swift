//
//  RZGCD.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/26.
//  Copyright © 2020 rztime. All rights reserved.
//

import Foundation
import UIKit

protocol RZGCDTask {
    /// 任务开始
    func star()
    /// 任务结束
    func end()
}

struct RZGCD {
    public enum RZGCDThred {
        /// 主线程
        case main
        /// 后台线程
        case global
    }
    
    public enum RZGCDType {
         /// 串行
        case line
        /// 并行
        case parallel
    }
    /// 延迟执行 （秒） 默认在主线程执行
    public static func after(timer:TimeInterval, thred:RZGCDThred = .main, exe:@escaping (()->Void)) {
        let queue = thred == .main ? DispatchQueue.main : DispatchQueue.global()
        queue.asyncAfter(deadline: .now() + timer) {
            exe()
        }
    }
    
    /// 执行(多)任务 (默认在后台线程执行并行任务)
    /// - Parameters:
    ///   - queue: 执行的线程 (主线程 或 全局后台线程)
    ///   - type: 串行、并行
    ///   - task: 每一个任务需要接入 star（） end（）
    ///   - complete: 所有任务执行完之后，汇总
    public static func executeOn(thred:RZGCDThred = .global, type:RZGCDType = .parallel, task:((RZGCDTask) -> Void)? = nil, complete:(() -> Void)? = nil) {
        let queue = thred == .main ? DispatchQueue.main : DispatchQueue.global()
        queue.async {
            switch type {
            case .line: // 串行
                let sem = DispatchSemaphore(value: 0)
                task?(sem)
                DispatchQueue.main.async {
                    complete?()
                }
            case .parallel: // 并行
                let group = DispatchGroup()
                task?(group)
                group.notify(queue: DispatchQueue.main) {
                    complete?()
                }
            }
        }
    }
}

extension DispatchGroup : RZGCDTask {
    open func star() {
        self.enter()
    }
    open func end() {
        self.leave()
    }
}

extension DispatchSemaphore : RZGCDTask {
    open func star() {
        self.wait()
    }
    open func end() {
        self.signal()
    }
}



