//
//  CustomTableViewCell.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    
    func initSetup() {
        self.contentView.addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(self.contentView.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func setText(_ text: String) {
        titleLabel.text = text
    }
}
