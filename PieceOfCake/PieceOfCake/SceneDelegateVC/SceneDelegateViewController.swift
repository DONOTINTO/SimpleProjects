//
//  SceneDelegateViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/25/24.
//

import UIKit

class SceneDelegateViewController: UIViewController {

    let changeRootVCButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        self.tabBarItem.title = "TEST"
        self.navigationItem.title = "TEST"
    }
    
    @objc func changeRootVCButtonClicked(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        let homeVC = HomeVC()
        let naviVC = UINavigationController(rootViewController: homeVC)
        
        sceneDelegate.window?.rootViewController = naviVC
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(changeRootVCButton)
        
        changeRootVCButton.translatesAutoresizingMaskIntoConstraints = false
        changeRootVCButton.setTitle("ROOT VC 변경버튼", for: .normal)
        changeRootVCButton.setTitleColor(.black, for: .normal)
        changeRootVCButton.backgroundColor = .systemYellow
        changeRootVCButton.addTarget(self, action: #selector(changeRootVCButtonClicked(_:)), for: .touchUpInside)
        
        changeRootVCButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        changeRootVCButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        changeRootVCButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        changeRootVCButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
