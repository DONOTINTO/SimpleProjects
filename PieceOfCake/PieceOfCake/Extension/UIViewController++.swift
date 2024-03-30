//
//  UIViewController++.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/25/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, msg: String, okTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
