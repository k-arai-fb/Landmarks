//
//  PageControl.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/17.
//

import SwiftUI
import UIKit


struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        // イベント発生時に呼び出す処理（ターゲット・アクション）を登録する UIKit の仕組み
        control.addTarget(
            context.coordinator,
            // Objective-C のメソッド（関数）の「名前（識別子）」を参照するための記法
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return control
    }
    
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    
    class Coordinator: NSObject {
        var control: PageControl
        
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        // セレクタから呼び出すため
        @objc
        // sender から現在のページを取得
        // @Binding 経由で SwiftUI 側の currentPage に反映
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
