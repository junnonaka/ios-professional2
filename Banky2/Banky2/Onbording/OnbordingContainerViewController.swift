//
//  OnbordingContainerViewController.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/02.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    //UIPageViewControllerのインスタンス化
    let pageViewController: UIPageViewController
    //ページの配列
    var pages = [UIViewController]()
    //現在のViewController
    var currentVC: UIViewController {
        didSet {
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        //pageViewControllerの初期化
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        //3つのページを作製
        let page1 = OnbordingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")

        let page2 = OnbordingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and sacurity")

        let page3 = OnbordingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com")

        
        //ページ配列に追加
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewの背景をsystemPurpleに変更
        view.backgroundColor = .systemPurple
        
        //プログラマブルUIKitを使う時の３つのステップ：子ViewControllerを親ViewControllerに埋め込む時に使う
        //ViewControlloerの親子関係を作る：全てのUIViewControllerが接続される
        //これを行うと全てのViewControllerのライフサイクルイベントが実行される
        //ChileViewを追加する
        addChild(pageViewController)
        //viewにpageViewControllerのviewを追加する
        view.addSubview(pageViewController.view)
        //pageViewControllerをPagrentViewControllerに移動させる。
        pageViewController.didMove(toParent: self)
        
        //pageViewControllerのdelegateにセットする
        pageViewController.dataSource = self
        //手動Autolayoutを機能するようにする
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //pageViewControllerをそれぞれの上下左右につけている
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        //pageViewControllerの最初のページをセットしている
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        //現在のVCを設定
        currentVC = pages.first!
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    //前のページに戻る動作をした時の処理：表示させるViewControllerを取得している
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    //次のページに移る動作をした時の処理：表示させるViewControllerを取得している
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    //前のページに戻るとき：indexを超えていないことを確認して、なければnilつまりViewControllerを渡さない
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    //次のページに移るとき：indexを超えていないことを確認して、なければnilつまりViewControllerを渡さない
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    //
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

