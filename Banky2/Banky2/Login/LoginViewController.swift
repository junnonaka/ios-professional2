//
//  ViewController.swift
//  Banky
//
//  Created by 野中淳 on 2022/01/30.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    //MVVMに通づる部分がある
    var userName:String?{
        return loginView.usernameTextField.text
    }
    
    var password:String?{
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()

        // Do any additional setup after loading the view.
    }
}
extension LoginViewController{
    private func style(){
        //falseにしないとAUtolayoutが機能しない
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        //Autolayoutを機能するようにする
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        //塗りつぶしのスタイル：iOS15以降から
        signInButton.configuration = .filled()
        //画像とテキスト間のpadding
        signInButton.configuration?.imagePadding = 8 //for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        //primaryActionTriggered：ボタンが選択されたときに実行される
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        //Autolayoutを機能するようにする
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        
    }
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        //配列なので複数の制約を入れることができる
        //LoginView
        NSLayoutConstraint.activate([
            //loginviewのY方向中央に配置
            loginView.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            //loginviewの左側をviewの左側に揃える：multiplierは1だが8px離れるようになる
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            //こちらが正しい
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
            //こっちだとloginViewがviewの右端についてしまう。
            //loginView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1)
            
        ])
        
        //signInButton
        NSLayoutConstraint.activate([
            //multiplierは8の乗数になる。pxで指定したい時は？equalToで指定する
            //signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 16),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //errorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
    }
    
}
//Actionで分ける
extension LoginViewController{
    @objc private func signInTapped(sender:UIButton){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = userName,let password = password else{
            //来た時に意図的にバグだとわかるように仕込む：プログラムのエラーの場合に仕込む
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty{
            configureView(withMessage: "usernamer / password cannot be blank")
            return
        }
        
        //今回の講義はバックエンドはやらないのでハードコーディングしている
        if username == "jun" && password == "jun"{
            //グルグルを表示させる
            signInButton.configuration?.showsActivityIndicator = true
        }else{
            configureView(withMessage: "Incorrect username / password")
        }
        
    }

    private func configureView(withMessage message:String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}