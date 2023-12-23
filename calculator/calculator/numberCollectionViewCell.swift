//
//  numberCollectionViewCell.swift
//  calculator
//
//  Created by 이중엽 on 12/20/23.
//

import UIKit
import SnapKit

class numberCollectionViewCell: UICollectionViewCell {
    let labelButton = UIButton()
    
    func setImage(_ text: String) {
        self.labelButton.setTitle(text, for: .normal)
    }
    
    func initSetup() {
        self.contentView.addSubview(labelButton)
        labelButton.configuration?.titleAlignment = .center
        labelButton.backgroundColor = .white
        labelButton.setTitleColor(.black, for: .normal)
    }
    
    func setConstraints() {
        labelButton.snp.makeConstraints {
            $0.edges.equalTo(self.contentView.snp.edges)
        }
    }
}
