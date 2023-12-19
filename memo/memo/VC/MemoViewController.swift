//
//  MemoViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class MemoViewController: UIViewController {
    let myView = MemoView()
    var idx: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.makeUI()
        self.view = myView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
    }
    
    func setIndex(_ idx: Int) {
        self.idx = idx
    }
    
    @objc func doneButtonClicked() {
        let text = myView.mainTextField.text
        idx == nil ? Storage.shared.addData(text) : Storage.shared.editData(text, idx: self.idx!)
        
        self.navigationController?.popViewController(animated: true)
    }

}
