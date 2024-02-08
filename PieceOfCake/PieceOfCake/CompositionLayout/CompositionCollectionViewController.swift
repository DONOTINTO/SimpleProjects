//
//  CompositionCollectionViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/7/24.
//

import UIKit
import SnapKit

class CompositionCollectionViewController: UIViewController {

    // CompositionalLayout 설정
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CompositionalLayout.create())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Custom Cell 등록
        collectionView.register(CompositionalCollectionViewCell.self, forCellWithReuseIdentifier: CompositionalCollectionViewCell.identifier)
        
        // Custom Header 등록
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    
}

extension CompositionCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Section 갯수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CompositionalLayout.count
    }
    
    // Section 내 item 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = CompositionalLayout(rawValue: section) else { return 0}
        
        switch sectionType {
        case .styleA:
            return 10
        case .styleB:
            return 20
        case .styleC:
            return 10
        }
    }
    
    // Section 타입 별 Cell 생성 및 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCollectionViewCell.identifier, for: indexPath) as? CompositionalCollectionViewCell else { return UICollectionViewCell() }
        
        let randomRed = CGFloat.random(in: 0 ... 1)
        let randomGreen = CGFloat.random(in: 0 ... 1)
        let randomBlue = CGFloat.random(in: 0 ... 1)
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        if let sectionType = CompositionalLayout(rawValue: indexPath.section) {
            switch sectionType {
            case .styleA:
                cell.label.text = "section A \(indexPath.item)"
                cell.myView.backgroundColor = randomColor
            case .styleB:
                cell.label.text = "section B \(indexPath.item)"
                cell.myView.backgroundColor = randomColor
            case .styleC:
                cell.label.text = "section C \(indexPath.item)"
                cell.myView.backgroundColor = randomColor
            }
        }
        
        return cell
    }
    
    // Section Header 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
            
            if let sectionType = CompositionalLayout(rawValue: indexPath.section) {
                switch sectionType {
                case .styleA:
                    header.titleLabel.text = "Section A"
                case .styleB:
                    header.titleLabel.text = "Section B"
                case .styleC:
                    header.titleLabel.text = "Section C"
                }
            }
            
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}
