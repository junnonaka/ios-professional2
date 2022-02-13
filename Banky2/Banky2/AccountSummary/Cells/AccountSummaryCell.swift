//
//  AccontSummaryCell.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/08.
//

import Foundation
import UIKit

class AccountSummaryCell:UITableViewCell{
    
    //viewModelで使う
    enum AccountType:String{
        case Banking
        case CreditCard
        case Investment
    }
    
    //ViewModel定義
    struct ViewModel{
        let accountType:AccountType
        let accountName:String
        let balance:Decimal

        var balanceAsAttributedString:NSAttributedString{
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    //セルがロードされた時は全てのデータが揃っていないので初期値はnil
    let viewModel:ViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccontSummaryCell"
    static let rowHeight:CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup(){
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        //端末のフォントサイズの変更に合わせる：ダイナミックフォント
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        //セルにはcontentViewというセル自体のビューがあるのでそれに追加する
        contentView.addSubview(typeLabel)

        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        contentView.addSubview(underlineView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "Name"
        contentView.addSubview(nameLabel)
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.adjustsFontForContentSizeCategory = true
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "903,988", cents: "23")
        
        //積んでいる順番にaddしていく
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(balanceStackView)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(chevronImageView)
        
        
    }
    private func layout(){
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4)

        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
        ])
        
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func makeFormattedBalance(dollars:String,cents:String) -> NSMutableAttributedString{
        
        let dollarSignAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .callout),.baselineOffset: 8]
        let dollarAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .footnote),.baselineOffset: 8]

        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollerString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollerString)
        rootString.append(centString)
        
        return rootString
    }
 }

//viewModelのconfigure
extension AccountSummaryCell{
    func configure(with vm:ViewModel){
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType{
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current balance"
            break
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
            break
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
            break
        }
        
        
    }
}
