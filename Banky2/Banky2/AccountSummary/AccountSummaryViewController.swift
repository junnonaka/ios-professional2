//
//  AccountSummaryViewController.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/07.
//

import UIKit

class AccountSummaryViewController: UIViewController {

    //Request Models
    var profile:Profile?
    var accounts:[Account] = []
    
    //ViewModels
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "welcome", name: "", date: Date())
    var accountCellViewModels:[AccountSummaryCell.ViewModel] = []
   
    //インスタンス化
    var tableView = UITableView()
    //ヘッダーを初期サイズ無しで初期化
    var headerView = AccountSummaryHeaderView(frame: .zero)

    lazy var logoutBarButtonItem:UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableViewHeaderView()
//        fetchAccounts()
        fetchDataAndLoadViews()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        //delegateとdatasourceにセット
        tableView.delegate = self
        tableView.dataSource = self
        
        //Cell自体にreuseIdentifierのプロパティを持たせると参照だけで済む
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        //FooterはからのViewを入れる：非表示になる
        tableView.tableFooterView = UIView()
        
        //Autolayoutを機能するようにする
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableviewをViewに追加
        view.addSubview(tableView)
        //tableviewをview全体に設定
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableViewHeaderView(){
        //可能な限り小さいサイズでHeaderのサイズを取得
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        //幅を設定:端末によってサイズが変わるため
        size.width = UIScreen.main.bounds.width
        //headerにサイズを設定
        headerView.frame.size = size
        //headerをtableviewに設定
        tableView.tableHeaderView = headerView
    }

}

//datasourceプロトコル
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModels.isEmpty else{ return UITableViewCell()}
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        //viewModelの設定
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

//delegateプロトコル
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//extension AccountSummaryViewController {
//    private func fetchAccounts() {
//        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                            accountName: "Basic Savings",
//                                                        balance: 929466.23)
//        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                    accountName: "No-Fee All-In Chequing",
//                                                    balance: 17562.44)
//        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Visa Avion Card",
//                                                       balance: 412.83)
//        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Student Mastercard",
//                                                       balance: 50.83)
//        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Tax-Free Saver",
//                                                       balance: 2000.00)
//        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Growth Fund",
//                                                       balance: 15000.00)
//
//        accountCellViewModels.append(savings)
//        accountCellViewModels.append(chequing)
//        accountCellViewModels.append(visa)
//        accountCellViewModels.append(masterCard)
//        accountCellViewModels.append(investment1)
//        accountCellViewModels.append(investment2)
//    }
//}
extension AccountSummaryViewController{
    @objc func logoutButtonTapped(){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

//MARK: - Networking
extension AccountSummaryViewController{
    private func fetchDataAndLoadViews(){
        fetchProfile(forUserId: "1") { result in
            switch result{
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //ハードコーディングされた関数
        //fetchAccounts()
        //ネットワークを使った関数に変更
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableHeaderView(with profile:Profile){
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
        
    }
    
    private func configureTableCells(with accounts:[Account]){
        accountCellViewModels = accounts.map{
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
}
