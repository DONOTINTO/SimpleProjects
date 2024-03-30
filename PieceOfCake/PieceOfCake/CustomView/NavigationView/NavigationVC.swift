//
//  NavigationVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/26/24.
//

import UIKit

class NavigationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // 네비게이션 뒤로가기 버튼 제목 설정
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        // 네비게이션 틴트 컬러 설정
        self.navigationController?.navigationBar.tintColor = .black
        
        // Title View를 직접 생성하여 적용
        let titleLabel = UILabel()
        titleLabel.text = "테스트입니다"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        self.navigationItem.titleView = titleLabel
        
        // 오른쪽 Bar 버튼 아이템 추가
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonClicked(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightBarButtonClicked(_ sender: UIBarButtonItem) {
        print("여기요")
    }
    
}
