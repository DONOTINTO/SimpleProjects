//
//  MemoView.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit
import SnapKit

class MemoView: UIView {

    let mainTextField = UITextView()
    
    func initSetup() {
        self.addSubview(mainTextField)
    }
    
    func makeUI() {
        backgroundColor = .white
    }
    
    func setConstraints() {
        mainTextField.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }

}
