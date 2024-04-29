//
//  LifeCycleHomeViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 4/29/24.
//

import UIKit
import SnapKit

class LifeCycleHomeViewController: UIViewController {

    let presentButton = UIButton()
    let pushButton = UIButton()
    let pageVC = UIPageViewController()
    
    override func loadView() {
        super.loadView()
        
        print("superview", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("superview", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("superview", #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        print("superview", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("superview", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("superview", #function)
    }
    
    deinit {
        print("superview deinit")
    }
}

extension LifeCycleHomeViewController {
    
    func configure() {
        
        [presentButton, pushButton].forEach { view.addSubview($0) }
        
        presentButton.snp.makeConstraints {
            
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalTo(view).inset(30)
            $0.height.equalTo(44)
        }
        
        pushButton.snp.makeConstraints {
            
            $0.top.equalTo(presentButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view).inset(30)
            $0.height.equalTo(44)
        }
        
        presentButton.addTarget(self, action: #selector(presentButtonClicked), for: .touchUpInside)
        pushButton.addTarget(self, action: #selector(pushButtonClicked), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        presentButton.setTitle("present", for: .normal)
        presentButton.backgroundColor = .systemBlue
        
        pushButton.setTitle("push", for: .normal)
        pushButton.backgroundColor = .systemBlue
    }
    
    @objc func presentButtonClicked() {
        
        let nextVC = PresentViewController()
        self.present(nextVC, animated: true)
    }
    
    @objc func pushButtonClicked() {
        
        let nextVC = PushViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
