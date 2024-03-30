//
//  NSObject++.swift
//  PieceOfCake
//
//  Created by 이중엽 on 3/30/24.
//

import Foundation

extension NSObject {
    
    var vcTitle: String {
        let title = String(describing: self).components(separatedBy: ".")[1].components(separatedBy: ":")[0]
        return title
    }
}
