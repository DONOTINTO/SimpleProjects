//
//  WorkVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/10/24.
//

import UIKit

class DelegateVC: UIViewController {
    
    let mainLabel = UILabel()
    let mainButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.mainLabel.text = "수신 대기중"
        self.mainButton.setTitle("클릭", for: .normal)
        self.mainButton.backgroundColor = .lightGray
        self.mainButton.addTarget(self, action: #selector(mainButtonClicked(_:)), for: .touchUpInside)
        
        self.view.addSubview(mainLabel)
        self.view.addSubview(mainButton)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func mainButtonClicked(_ sender: UIButton) {
        let nextVC = WorkVC()
        print("대리자 위임")
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension DelegateVC: DelegateProtocol {
    func changeLableText(text: String) {
        print("수신 완료")
        mainLabel.text = text
        mainButton.backgroundColor = .orange
    }
}
