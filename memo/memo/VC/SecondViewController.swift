//
//  SecondViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class SecondViewController: UIViewController {
    let myView = SecondView()
    
    override func viewWillAppear(_ animated: Bool) {
        myView.tableView.reloadData()
    }
    
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
        let nextVC = MemoViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myView.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.makeUI()
        
        let text = Storage.shared.getData(idx: indexPath.row)
        cell.setText(text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.shared.remove(idx: indexPath.row)
            myView.tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MemoViewController()
        nextVC.idx = indexPath.row
        nextVC.myView.mainTextField.text = Storage.shared.getData(idx: indexPath.row)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
