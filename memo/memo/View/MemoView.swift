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
    
    func makeUI() {
        self.addSubview(mainTextField)
        backgroundColor = .white
        mainTextField.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }

}
