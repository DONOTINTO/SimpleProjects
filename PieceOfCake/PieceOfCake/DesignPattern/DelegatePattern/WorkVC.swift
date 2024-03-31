//
//  DelegateVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/10/24.
//

import UIKit

class WorkVC: UIViewController {
    let mainButton = UIButton()
    var delegate: DelegateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.mainButton.setTitle("클릭", for: .normal)
        self.mainButton.backgroundColor = .lightGray
        self.mainButton.addTarget(self, action: #selector(mainButtonClicked(_:)), for: .touchUpInside)
        
        self.view.addSubview(mainButton)
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func mainButtonClicked(_ sender: UIButton) {
        print("실행 요청")
        delegate?.changeLableText(text: "수신 완료")
    }
}
