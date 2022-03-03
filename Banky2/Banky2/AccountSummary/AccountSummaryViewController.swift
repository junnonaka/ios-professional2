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
   
    //Components
    //インスタンス化
    var tableView = UITableView()
    //ヘッダーを初期サイズ無しで初期化
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    //Networking
    var profileManager:ProfileManageable = ProfileManager()
    
    //Error alert
    lazy var errorAlert:UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    var isLoaded = false

    lazy var logoutBarButtonItem:UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
    }
    

}

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()
        setupTableView()
        setupTableViewHeaderView()
        setupRefreshControl()
        setupSkeltons()
//        fetchAccounts()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        //delegateとdatasourceにセット
        tableView.delegate = self
        tableView.dataSource = self
        
        //Cell自体にreuseIdentifierのプロパティを持たせると参照だけで済む
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)

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

    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeltons(){
        let row = Account.makeSkelton()
        //スケルトンローダーをaccountsに最初に入れておく
        accounts = Array(repeating: row, count: 10)
        configureTableCells(with: accounts)
    }

}

//datasourceプロトコル
extension AccountSummaryViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard !accountCellViewModels.isEmpty else{ return UITableViewCell()}
//
//        let cell =  tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
//        let account = accountCellViewModels[indexPath.row]
//        //viewModelの設定
//        cell.configure(with: account)
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        let account = accountCellViewModels[indexPath.row]

        //ロード中の場合はスケルトンローダーを表示
        if isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        //ロードが完了していれば通常のセルを表示
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
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


//MARK: - Networking
extension AccountSummaryViewController{
    
    
    private func fetchData(){
        //①group作成
        let group = DispatchGroup()
        
        //Testing - random number selection
        let userId = String(Int.random(in: 1..<4))
        
       
        fetchAccount(group: group, userId: userId)
        fetchProfile(group: group, userId: userId)
        
        //③groupで全てが完了したら実行させる
        group.notify(queue: .main) {
            self.reloadView()
        }
        
    }
    
    private func fetchProfile(group:DispatchGroup,userId:String){
        //②groupに追加
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result{
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                self.displayError(error)
            }
            //groupに追加
            group.leave()
        }
    }
    
    private func fetchAccount(group:DispatchGroup,userId:String){
        //②groupに追加
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            //groupに追加
            group.leave()
        }
    }
    
    private func reloadView() {
        //リフレッシュを完了させる
        self.tableView.refreshControl?.endRefreshing()
        guard let profile = self.profile else{return}
        //スケルトンローダー表示をやめさせる
        self.isLoaded = true
        self.tableView.reloadData()
        self.configureTableHeaderView(with: profile)
        self.configureTableCells(with: self.accounts)
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
    

    
    private func displayError(_ error:NetworkError){
        
        let titleAndMessage = titleAndMessage(for:error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    
    private func titleAndMessage(for error:NetworkError)->(String,String){
        let title:String
        let message:String
        //print(error.localizedDescription)
        switch error {
        case .serverError:
            title = "Server Error"
            message = "We could not process your request. Please try again."
        case .decodingError:
            title = "Network Error"
            message = "Ensure you are connected to the internet. Please try again."
        }
        //tuple形式で返している
        return (title,message)
    }
    
    
    //アラート表示
    private func showErrorAlert(title:String,message:String) {


        
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        errorAlert.title = title
        errorAlert.message = message
        
        present(errorAlert, animated: true, completion: nil)
    }
}

//MARK: - Actions
extension AccountSummaryViewController{
    @objc func logoutButtonTapped(){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
//    @objc func refreshContent(){
//        fetchData()
//    }
    //リフレッシュでスケルトンローダーを表示する
    @objc func refreshContent(){
        //データを一旦消去する
        reset()
        setupSkeltons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}

//MARK: - Unit testing　※private関数をテストするためにprivateではないものからアクセスできるようにしている
extension AccountSummaryViewController{
    func titleAndMessageForTesting(for error: NetworkError) -> (String,String){
        return titleAndMessage(for: error)
    }
    
    func forceFetchProfile(){
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
}
