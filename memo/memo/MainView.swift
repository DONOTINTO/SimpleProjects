//
//  MainView.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let enterButton = UIButton()
    
    func makeUI() {
        self.backgroundColor = .white
        self.addSubview(enterButton)
        
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.backgroundColor = .black
        enterButton.layer.cornerRadius = 10
        
        enterButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(120)
            $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            $0.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
    }
}
