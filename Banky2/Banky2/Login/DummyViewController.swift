//
//  DummyViewController.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/05.
//

import Foundation
import UIKit


class DummyViewController:UIViewController{
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var logoutDelegate:LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension DummyViewController{
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        //#selector:SwiftからobjectCを呼び出したり参照したりすることが出来るタイプ
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout(){
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
        
    }
    //@objcはSwiftをobjectCとブリッジする方法:SwiftからobjectCにつなげている
    @objc func logoutButtonTapped(sender:UIButton){
        logoutDelegate?.didLogout()
    }
}
