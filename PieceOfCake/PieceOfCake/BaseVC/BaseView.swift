//
//  BaseView.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/18/24.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureHierarchy() { }
    
    override func configureLayout() { }
    
    override func configureView() { }

}
