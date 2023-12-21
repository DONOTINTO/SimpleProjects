//
//  numberCollectionViewCell.swift
//  calculator
//
//  Created by 이중엽 on 12/20/23.
//

import UIKit
import SnapKit

class numberCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    func setImage(_ text: String) {
        self.label.text = text
    }
    
    func initSetup() {
        self.contentView.addSubview(label)
        label.textAlignment = .center
        label.backgroundColor = .white
    }
    
    func setConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self.contentView.snp.edges)
        }
    }
}
