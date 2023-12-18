//
//  SecondView.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit
import SnapKit

class SecondView: UIView {

    let tableView = UITableView()
    
    func makeUI() {
        self.backgroundColor = .white
        self.addSubview(tableView)
    }
    
    func constraintView() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }

}
