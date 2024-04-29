//
//  PushViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 4/29/24.
//

import UIKit

class PushViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        print("push", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("push", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("push", #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        print("push", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("push", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("push", #function)
    }
    
    deinit {
        print("push deinit")
    }
}
