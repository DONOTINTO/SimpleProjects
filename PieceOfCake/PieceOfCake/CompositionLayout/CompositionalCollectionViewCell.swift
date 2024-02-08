//
//  CompositionalCollectionViewCell.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/8/24.
//

import UIKit
import SnapKit

class CompositionalCollectionViewCell: UICollectionViewCell {
    
    let myView = UIView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(myView)
        self.contentView.addSubview(label)
        
        self.label.text = "11111111"
        
        myView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.contentView)
            $0.height.equalTo(200)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(myView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
