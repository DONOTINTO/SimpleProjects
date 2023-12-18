//
//  CustomTableViewCell.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    
    func makeUI() {
        self.contentView.addSubview(titleLabel)
        titleLabel.text = "test"
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(self.contentView.safeAreaLayoutGuide.snp.edges)
        }
    }
}
