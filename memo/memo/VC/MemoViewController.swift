//
//  MemoViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class MemoViewController: UIViewController {
    let myView = MemoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.makeUI()
        self.view = myView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        let text = myView.mainTextField.text
        Storage.shared.addData(text)
        
        self.navigationController?.popViewController(animated: true)
    }

}
