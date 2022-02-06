//
//  UIViewController+Utils.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/06.
//

import UIKit

extension UIViewController{
    //statusbarのサイズのUIViewを取得する
    func setStatusBar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusbarView = UIView(frame: frame)
        
        statusbarView.backgroundColor = appColor
        view.addSubview(statusbarView)
    }
    //tabbarの画像と名称を設定する
    func setTabBarImage(imageName:String,title:String){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
