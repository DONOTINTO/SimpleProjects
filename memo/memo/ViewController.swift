//
//  ViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class ViewController: UIViewController {
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        
        mainView.makeUI()
        setAction()
    }
    
    func setAction() {
        mainView.enterButton.addTarget(self, action: #selector(addEnterButtonClicked), for: .touchUpInside)
    }

    @objc func addEnterButtonClicked() {
        
    }
}

