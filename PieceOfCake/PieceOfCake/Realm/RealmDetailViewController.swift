//
//  RealmDetailViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift

class RealmDetailViewController: UIViewController {

    let addButton = UIButton()
    let realmTableView = UITableView()
    var petObject: Results<Pet>!
    var person: Person!
    var complete: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Inverse Relationship을 이용해서 서로 연관된 데이터로 일치하는 오브젝트를 가져옴
        petObject = RealmManager().fetch(Pet.self).where {
            $0.person.id == person.id
        }
        
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
        addButton.setTitle("Pet Object 추가", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        realmTableView.dataSource = self
        realmTableView.delegate = self
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        // MARK: Pet 객체 생성 및 Realm에 추가
        let pet = Pet(type: "고양이")
        let realm = try! Realm()
        
        do {
            try realm.write {
                person.pets.append(pet)
            }
        } catch {
            print("추가 실패")
        }
        
        realmTableView.reloadData()
        
        complete?()
    }
}

extension RealmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let pet = petObject[indexPath.row]
        cell.textLabel?.text = pet.type
        
        // MARK: Inverse Relationship으로 Person 객체 정보 가져오기
        cell.detailTextLabel?.text = "\(pet.person.first?.name)"
        
        return cell
    }
}
