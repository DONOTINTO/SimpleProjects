//
//  SecondViewController.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import UIKit

class SecondViewController: UIViewController {
    let mainView = SecondView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.initSetup()
        mainView.makeUI()
        mainView.setConstraints()
        
        self.initSetup()
        self.navigationUI()
    }
    
    func initSetup() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    func navigationUI() {
        navigationItem.title = "메모장"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(rightButtonClicked))
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
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let text = Storage.shared.getData(idx: indexPath.row)
        
        cell.initSetup()
        cell.setConstraints()
        cell.setText(text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.shared.remove(idx: indexPath.row)
            mainView.tableView.deleteRows(at: [indexPath], with: .left)
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
