//
//  ViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var contentStackView: UIStackView!
    var contentListButtons = [UIButton]()
    var contentList = ["UIButton", "UITableView"]
    var vcList = [UIButtonViewController(), MyUITableViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        configureStackView()
    }

    func designUI() {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 5
        
        inputTextField.layer.cornerRadius = 10
        inputTextField.backgroundColor = .white
        inputTextField.borderStyle = .none
        inputTextField.layer.borderWidth = 2
        inputTextField.layer.borderColor = UIColor(.cyan).cgColor
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 5
        searchButton.setTitleColor(.systemCyan, for: .normal)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: imageConfiguration), for: .normal)
        searchButton.tintColor = .systemCyan
        searchButton.configuration = buttonConfiguration
    }
    
    func configureStackView() {
        contentStackView.spacing = 20
        
        //UIButton 스택에 추가
        for idx in 0 ..< contentList.count {
            var button: UIButton {
                let button = UIButton()
                button.setTitle(contentList[idx], for: .normal)
                button.backgroundColor = .systemCyan
                button.layer.cornerRadius = 10
                button.setTitleColor(.white, for: .normal)
                button.tag = idx
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
                return button
            }
            contentListButtons.append(button)
        }
        
        //버튼 뷰 추가
        contentListButtons.forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        let idx = sender.tag
        
        let nextVC = vcList[idx]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

