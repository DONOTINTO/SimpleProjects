//
//  HomeVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = HomeTableViewSection(rawValue: section)!
        
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = HomeTableViewSection(rawValue: indexPath.section)!
        let item = section.items[indexPath.item]
        
        cell.textLabel?.text = item.vcTitle
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = HomeTableViewSection(rawValue: indexPath.section)!
        let item = section.items[indexPath.item]

        navigationController?.pushViewController(item, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = HomeTableViewSection(rawValue: section)!
        
        return section.title.lowercased()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

// UI 관련
extension HomeVC {
   
    func configureHierarchy() {
        
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.sectionHeaderTopPadding = 25
    }
}

enum HomeTableViewSection: Int, CaseIterable {
    
    case customView
    case tableView
    case collectionView
    case scrollView
    case kit
    case library
    case rxSwift
    case designPattern
    case firebase
    
    var title: String {
        switch self {
        case .customView:
            return "customView"
        case .tableView:
            return "tableView"
        case .collectionView:
            return "collectionView"
        case .scrollView:
            return "scrollView"
        case .kit:
            return "kit"
        case .library:
            return "library"
        case .rxSwift:
            return "rxSwift"
        case .designPattern:
            return "designPattern"
        case .firebase:
            return "firebase"
        }
    }
    
    var items: [UIViewController] {
        switch self {
        case .customView:
            return [NavigationVC(), ButtonVC()]
        case .tableView:
            return [TableVC()]
        case .collectionView:
            return [CollectionVC(), CompositionalVC()]
        case .scrollView:
            return [ScrollVC()]
        case .kit:
            return [ImagePickerVC(), GooglePlaceVC(), CLMapKitVC()]
        case .library:
            return []
        case .rxSwift:
            return []
        case .designPattern:
            return [DelegateVC()]
        case .firebase:
            return []
        }
    }
}
