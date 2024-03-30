//
//  CollectionVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/12/24.
//

import UIKit

class CollectionVC: UIViewController {

    var myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designUI()
        constraintsUI()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        // Collection View에 Cell 등록
        myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        // collectionView 크기는 viewDidLoad 이후로 정해지기 때문에 비동기 처리를 통해 지연시킨다.
        DispatchQueue.main.async {
            
            // collectionView는 FlowLayout을 설정해주어야함
            let flowLayout = UICollectionViewFlowLayout()
            
            // 섹션 좌우 거리
            let leftRightInsetSpacing: CGFloat = 10
            
            // 섹션 상하 거리
            let topBottomInsetSpacing: CGFloat = 10
            
            // 셀(아이템) 별 거리
            let itemsInterSpacing: CGFloat = 5
            
            // 셀(아이템) 다음 라인과의 거리
            let lineSpacing: CGFloat = 5
            
            // Vertical 시 column 수 (Horizontal시에는 row 수)
            let column: CGFloat = 3
            
            // (프레임 너비 - (좌우 Inset 너비) - ((column - 1) * 아이템 거리))를 column 수로 나누면 아이템의 너비를 만들 수 있음
            let width = (self.myCollectionView.frame.width - (leftRightInsetSpacing * 2) - ((column - 1) * itemsInterSpacing)) / column
            
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: width, height: width)
            flowLayout.minimumLineSpacing = lineSpacing
            flowLayout.minimumInteritemSpacing = itemsInterSpacing
            flowLayout.sectionInset = .init(top: topBottomInsetSpacing, left: leftRightInsetSpacing, bottom: topBottomInsetSpacing, right: leftRightInsetSpacing)
            
            self.myCollectionView.collectionViewLayout = flowLayout
        }
    }
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    // CollectionView의 섹션 별 item 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // Cell(item) 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        item.backgroundColor = .brown
        
        return item
    }
    
    // Cell 선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension CollectionVC {
    func designUI() {
        self.navigationController?.navigationBar.tintColor = .black
        
        self.view.backgroundColor = .white
        myCollectionView.backgroundColor = .systemYellow
    }
    
    func constraintsUI() {
        self.view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        myCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

class CollectionViewCell: UICollectionViewCell {
    
}
