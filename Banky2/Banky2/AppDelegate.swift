//
//  AppDelegate.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self
        window?.rootViewController = loginViewController
        //window?.rootViewController = OnbordingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")

        return true
        
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

extension AppDelegate:LoginViewControllerDelegate{
    func didLogin() {
        if LocalState.hasOnborded{
            setRootViewController(dummyViewController)
        }else{
            setRootViewController(onboardingContainerViewController)

        }
    }
}

extension AppDelegate:OnboardingContainerViewControllerDelegate{
    func didFinishOnbording() {
        LocalState.hasOnborded = true
        setRootViewController(dummyViewController)
        
    }
   
}
extension AppDelegate:LogoutDelegate{
    func didLogout() {
        setRootViewController(loginViewController)
    }
}


