//
//  UITableViewCell.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit

class MyUITableViewCell: UITableViewCell {
    let title = UILabel()

    func constraint() {
            self.contentView.addSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false
        
        title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10).isActive = true
    }
}
