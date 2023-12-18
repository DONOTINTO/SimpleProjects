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
        self.setNavigationUI()
        self.setupUI()
    }
    
    func setNavigationUI() {
        navigationItem.title = "메모장"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightButtonClicked))
    }
    
    func setupUI() {
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        
        myView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    @objc func rightButtonClicked() {
        print("123")
    }

}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myView.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.makeUI()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension SecondViewController: UITableViewDelegate {
    
}
