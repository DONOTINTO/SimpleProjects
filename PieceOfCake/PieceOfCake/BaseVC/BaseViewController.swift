//
//  BaseViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/18/24.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController {

    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    override func loadView() {
        view = LayoutView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
