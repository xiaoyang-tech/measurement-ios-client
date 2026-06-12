//
//  BaseViewController.swift
//  measurementSDK_Example
//
//  Created by DCK on 2025/12/12.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.setupNavigationBar()
    }
    
    // MARK: - 核心设置
    /// 设置导航栏（含返回按钮）
    private func setupNavigationBar() {
        // 1. 确保导航栏显示
        navigationController?.isNavigationBarHidden = false
        // 2. 设置导航栏标题
        
        // 说明是通过 present UINavigationController 方式打开的（当前是导航栈第一个）
        let backButton = UIBarButtonItem(
                title: "返回",
                style: .plain,
                target: self,
                action: #selector(backAction)
            )
            // 可选：自定义返回按钮颜色
        backButton.tintColor = .gray
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - 导航返回方法
    /// 统一返回逻辑（适配 push/present 场景）
    @objc func backAction() {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            // 场景1：push 跳转 → pop 返回上一级
            navigationController?.popViewController(animated: true)
        } else {
            // 场景2：present 跳转 → dismiss 关闭当前页面
            dismiss(animated: true, completion: nil)
        }
    }
    
}
