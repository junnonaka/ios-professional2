//
//  AppDelegate.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/02.
//

import UIKit

let appColor:UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self

        registerNotification()
        
        displayLogin()
        return true
        
    }
    
    private func registerNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    private func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnborded{
            prepMainView()
            setRootViewController(mainViewController)
        }else{
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    private func prepMainView(){
        mainViewController.setStatusBar()
        //NavigationBarを半透明でなくす
        UINavigationBar.appearance().isTranslucent = false
        //NavigationBarの色を変更
        UINavigationBar.appearance().backgroundColor = appColor
        
    }
}

extension AppDelegate{
    func setRootViewController(_ vc:UIViewController,animated:Bool = true){
        guard animated, let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
}
//LoginViewControllerのDelegateメソッド
extension AppDelegate:LoginViewControllerDelegate{
    func didLogin() {
        displayNextScreen()
    }
}

//OnboardingContainerViewControllerのDelegateメソッド
extension AppDelegate:OnboardingContainerViewControllerDelegate{
    func didFinishOnbording() {
        LocalState.hasOnborded = true
        prepMainView()
        setRootViewController(mainViewController)
        
    }
   
}
//LoginViewControllerのDelegateメソッド
extension AppDelegate:LogoutDelegate{
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}


