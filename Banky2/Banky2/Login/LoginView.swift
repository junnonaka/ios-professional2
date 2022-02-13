//
//  LoginView.swift
//  Banky
//
//  Created by 野中淳 on 2022/01/30.
//

import Foundation
import UIKit

class LoginView:UIView{
    
    let stackView = UIStackView()
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        style()
        //プログラムによるAutoLayout
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize:CGSize{
//        return CGSize(width: 200, height: 200)
//    }
}

extension LoginView{
    
    func style(){
        /*translatesAutoresizingMaskIntoConstraintsは Auto Layout以前に使われていた、Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグです。
         デフォルトではオンになっていて、オンのままだと期待通りのAuto Layout設定ができない場合があるのでオフにします。*/
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //垂直方向
        stackView.axis = .vertical
        //スペースは8
        stackView.spacing = 8
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        //角丸にする
        layer.cornerRadius = 5
        clipsToBounds = true
        
    }
    
    func layout(){
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        //equalToConstant:定数に等しい
        //isActiveが必要。上のNSLayoutConstraint.activateに含めていないから
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
}

extension LoginView:UITextFieldDelegate{
    //Retturnキーを押されたとき
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //endEditignでキーボードを閉じる
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    //編集中かどうかを確認するためのコールバックメソッド
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
