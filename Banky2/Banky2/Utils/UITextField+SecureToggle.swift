//
//  UITextField+SecureToggle.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/13.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField{
    
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        //textFieldにボタン追加
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    //ボタンのタップでisSecureTextEntryをtoggleで切り替える
    @objc func togglePasswordView(_ sender:Any){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
