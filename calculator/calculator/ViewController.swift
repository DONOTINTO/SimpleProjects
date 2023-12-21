//
//  ViewController.swift
//  calculator
//
//  Created by 이중엽 on 12/20/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
            return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(numberCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        initSetup()
        setConstraints()
    }
    
    func initSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    func makeUI() {
        
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.centerY)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? numberCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setImage("1")
        cell.initSetup()
        cell.setConstraints()
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemCount: CGFloat = 3
        let interSpace: CGFloat = 10 * (itemCount - 1)
        let width = (collectionView.frame.width - interSpace) / itemCount
        
        return CGSize(width: width, height: width)
    }
}
