//
//  PresentViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 4/29/24.
//

import UIKit

class PresentViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        print("present", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("present", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("present", #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        print("present", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("present", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("present", #function)
    }
    
    deinit {
        print("present deinit")
    }
}
