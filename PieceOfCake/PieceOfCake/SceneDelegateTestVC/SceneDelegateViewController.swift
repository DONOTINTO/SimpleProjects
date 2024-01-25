//
//  SceneDelegateViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/25/24.
//

import UIKit

class SceneDelegateViewController: UIViewController {

    let label = UILabel()
    let button = UIButton()
    let changeRootVCButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        self.tabBarItem.title = "TEST"
        self.navigationItem.title = "TEST"
    }
    
    @objc func testButtonClicked(_ sender: UIButton) {
        print("클릭")
    }
    
    @objc func changeRootVCButtonClicked(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as? UINavigationController else { return }
        
        sceneDelegate.window?.rootViewController = newVC
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(label)
        self.view.addSubview(button)
        self.view.addSubview(changeRootVCButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "TEST"
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TEST BUTTON", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(testButtonClicked(_:)), for: .touchUpInside)
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        changeRootVCButton.translatesAutoresizingMaskIntoConstraints = false
        changeRootVCButton.setTitle("CHANGE ROOT VC BUTTON", for: .normal)
        changeRootVCButton.setTitleColor(.black, for: .normal)
        changeRootVCButton.backgroundColor = .systemYellow
        changeRootVCButton.addTarget(self, action: #selector(changeRootVCButtonClicked(_:)), for: .touchUpInside)
        
        changeRootVCButton.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        changeRootVCButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        changeRootVCButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
