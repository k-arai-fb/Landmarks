//
//  PageViewController.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/17.
//

import SwiftUI
import UIKit

//UIViewControllerが用意される

// PageViewController　SwiftUIから使うカスタムコンポーネント
// UIViewControllerRepresentable UIKit の UIPageViewController を SwiftUI に持ち込む仕組み
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    // 表示するページを配列で渡す
    var pages: [Page]
    // ページ変更を双方向に同期するための SwiftUI のバインディング
    @Binding var currentPage: Int
    
    // SwiftUI が UIKit のデリゲート機能を使えるようにするためのメソッド UIKitを使いやすく
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // UIPageViewController を作る
    // UIViewControllerRepresentableを使うと自動で実行
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            // 左右のスワイプ
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        // dataSource / delegate に Coordinator を指定
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    
    // SwiftUIでcurrentPageがへんかしたときに、UIKit側にも反映する
    // SwiftUIの状態が変化する時呼び出される
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        // setViewControllers() 表示中のページを変更
        pageViewController.setViewControllers(
            // SwiftUI から今表示すべきページ（インデックス）を取得して、その ViewController を選ぶ
            // 配列の中身が.firstになる
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    // UIKit のデリゲート／データソースを SwiftUI で扱うためのブリッジ役
    //UIViewControllerとやりとりをする部分
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            // SwiftUI の View（pages）を UIHostingController に変換して UIKit で扱えるようにする
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        // スワイプで前のページに行く処理
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            // 最初のページなら最後のページを返す
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        // スワイプで次のページに行く処理
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            // 最後のページなら最初のページを返す
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        // デリゲートメソッド
        // アニメーションが終了し、ページが切り替わった後
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
                // 現在表示されているページのインデックスを SwiftUI 側に反映
                if completed,
                   let visibleViewController = pageViewController.viewControllers?.first,
                   let index = controllers.firstIndex(of: visibleViewController) {
                    parent.currentPage = index
                }
            }
    }
}

