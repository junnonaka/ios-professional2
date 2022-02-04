//
//  OnbordingViewController.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/04.
//

import Foundation
import UIKit

class OnbordingViewController:UIViewController{
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()

    //初期化で使用する変数
    let heroImageName:String
    let titleText:String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    //初期化
    init(heroImageName:String,titleText:String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    //init時に必要になる
    //何故か？：UIViewControllerから継承しているコンストラクタ(初期化)だから
    //ストーリーボードを使う場合は必須
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnbordingViewController{
    
    func style(){
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: heroImageName)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        //デバイスのContentSizeCategoryに応じてフォントサイズを変更できるようにする
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = titleText

        }
    
    func layout(){
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        
    }
    
}
