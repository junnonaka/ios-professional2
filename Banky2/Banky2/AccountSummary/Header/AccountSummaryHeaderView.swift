//
//  AccountSummaryHeaderView.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/07.
//

import UIKit

class AccountSummaryHeaderView:UIView{
    
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //intrinsicContentSize:それ自体を表示するための固有のサイズ
    //高さを144で固有のサイズにする
    //例えば、stackViewとかscrollViewとかに追加した時、本来のサイズがなんなのかを示すために重要
    //保険のようなもの
    override var intrinsicContentSize: CGSize{
        //noIntrinsicMetric:固有のサイズなし
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit(){
        //自身のBundleを取得してnibのownerに設定する
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        //nibのcontentViewをViewに追加
        addSubview(contentView)
        //色を変更
        contentView.backgroundColor = appColor
        
        //contentViewを全ての四辺と合わせる
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
