//
//  HeaderCollectionReusableView.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/8/24.
//

import UIKit
import SnapKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.backgroundColor = .systemOrange
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(self).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}
