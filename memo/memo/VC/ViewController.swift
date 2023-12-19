//
//  ViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class ViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.initSetup()
        mainView.makeUI()
        mainView.setConstraints()
        
        setAction()
    }
    
    func setAction() {
        mainView.enterButton.addTarget(self, action: #selector(enterButtonClicked), for: .touchUpInside)
    }

    @objc func enterButtonClicked() {
        let nextView = UINavigationController(rootViewController: SecondViewController())
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true)
    }
}

