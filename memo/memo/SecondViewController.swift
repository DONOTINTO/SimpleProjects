//
//  SecondViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class SecondViewController: UIViewController {
    let myView = SecondView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.makeUI()
        myView.constraintView()
        
        self.view = myView
        self.setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "메모장"
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        
        myView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }

}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myView.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension SecondViewController: UITableViewDelegate {
    
}
