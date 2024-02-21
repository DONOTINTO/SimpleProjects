//
//  RealmViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift

class RealmViewController: UIViewController {
    
    let addButton = UIButton()
    let realmTableView = UITableView()
    var personObject: Results<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Realm내 Person Object 호출
        personObject = RealmManager().fetch(Person.self)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(addButton)
        view.addSubview(realmTableView)
        
        addButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        realmTableView.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.backgroundColor = .systemBlue
        addButton.setTitle("Person Object 추가", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        realmTableView.dataSource = self
        realmTableView.delegate = self
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        // MARK: Person 객체 생성 및 Realm에 추가
        let person = Person(name: "이름", gender: true)
        
        RealmManager().add(person)
        
        realmTableView.reloadData()
    }
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let person = personObject[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = "\(person.pets.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = RealmDetailViewController()
        
        let person = personObject[indexPath.row]
        // MARK: 다음 VC로 Person 객체 정보 전달
        nextVC.person = person
        nextVC.complete = {
            tableView.reloadData()
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
