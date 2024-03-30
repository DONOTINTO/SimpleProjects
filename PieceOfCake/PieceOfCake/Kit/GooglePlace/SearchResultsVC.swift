//
//  SearchResultsVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 3/5/24.
//

import UIKit
import SnapKit

class SearchResultsVC: UIViewController {
    
    private let tableView = UITableView()
    
    private var places: [Place] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    func configure() {
        
        view.backgroundColor = .brown
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func update(with places: [Place]) {
        self.places = places
        tableView.reloadData()
    }
}

extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = places[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
