//
//  MemoViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class MemoViewController: UIViewController {
    let mainView = MemoView()
    var idx: Int? = nil
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.initSetup()
        mainView.makeUI()
        mainView.setConstraints()
        
        self.setAction()
    }
    
    func setAction() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
    }
    
    func setIndex(_ idx: Int) {
        self.idx = idx
    }
    
    @objc func doneButtonClicked() {
        let text = mainView.mainTextField.text
        idx == nil ? Storage.shared.addData(text) : Storage.shared.editData(text, idx: self.idx!)
        
        self.navigationController?.popViewController(animated: true)
    }
}
