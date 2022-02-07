//
//  MainViewController.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/06.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews(){
        //ViewControllerのインスタンス化
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        //tabbarに画像とテキストをセット
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        //それぞれのNavigationControllerをインスタンス化
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)

        //navigationbarの色を変更
        summaryNC.navigationBar.barTintColor = appColor
        //navigationbarは非表示にする
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC,moneyNC,moreNC]
        viewControllers = tabBarList
        
    }
    
    private func hideNavigationBarLine(_ navigationBar:UINavigationBar){
        //空の画像を作製して各imageにセット
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        //navigationBar.isHidden = true
        //透明にする
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar(){
        tabBar.tintColor = appColor
        //透明にする
        tabBar.isTranslucent = false
    }
    
}



class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange

    }
}
class MoreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}
