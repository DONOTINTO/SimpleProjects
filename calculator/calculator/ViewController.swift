//
//  ViewController.swift
//  calculator
//
//  Created by 이중엽 on 12/20/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let items: [String] = ["C", "+/-", "%", "÷", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="]
    let minimumLineSpace: CGFloat = 1
    let minimumInteritemSpace: CGFloat = 1
    
    var firstInput: String = ""
    var secondInput: String = ""
    var signInput: String? = nil
    
    let numberView = UIView()
    let numberLabel = UILabel()
    // UICollectionView의 FlowLayout 설정하여 생성
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
        makeUI()
        setConstraints()
    }
    
    func initSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(numberView)
        self.view.addSubview(numberLabel)
        
        numberLabel.textColor = .white
        numberLabel.textAlignment = .right
        numberLabel.font = .systemFont(ofSize: 32)
    }
    
    func makeUI() {
        numberView.backgroundColor = .black
        numberLabel.backgroundColor = .black
        numberLabel.text = ""
    }
    
    func setConstraints() {
        numberView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.centerY).offset(-(self.view.frame.height / 4))
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.numberView.snp.centerX)
            $0.centerY.equalTo(self.numberView.snp.centerY).offset(30)
            $0.height.equalTo(self.numberView.snp.height).dividedBy(2)
            $0.leading.equalTo(self.numberView.snp.leading).inset(10)
            $0.trailing.equalTo(self.numberView.snp.trailing).inset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.numberView.snp.bottom)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }

    @objc func buttonClicked(sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        var result = 0
        
        switch text {
        case "1","2","3","4","5","6","7","8","9","0":
            if signInput == nil {
                firstInput.append(text)
                numberLabel.text = firstInput
            } else {
                secondInput.append(text)
                numberLabel.text = secondInput
            }
            break
        case "C":
            firstInput = ""
            secondInput = ""
            numberLabel.text = ""
            break
        case "%":
            signInput = "%"
            numberLabel.text = ""
            break
        case "÷":
            signInput = "÷"
            numberLabel.text = ""
            break
        case "x":
            signInput = "x"
            numberLabel.text = ""
            break
        case "+":
            signInput = "+"
            numberLabel.text = ""
            break
        case "-":
            signInput = "-"
            numberLabel.text = ""
            break
        case "=":
            switch signInput {
            case "%":
                result = Int(firstInput)! % Int(secondInput)!
                break
            case "÷":
                result = Int(firstInput)! / Int(secondInput)!
                break
            case "x":
                result = Int(firstInput)! * Int(secondInput)!
                break
            case "+":
                result = Int(firstInput)! + Int(secondInput)!
                break
            case "-":
                result = Int(firstInput)! - Int(secondInput)!
                break
                
            default:
                break
            }
            numberLabel.text = String(result)
            firstInput = ""
            secondInput = ""
            signInput = nil
        default:
            break
        }
        
        reloadInputViews()
    }
}

extension ViewController: UICollectionViewDataSource {
    // numberOfItemsInSection
    // collecntionView Section 안에 들어갈 item의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // cellForItemAt
    // collectionView cell을 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? numberCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setImage(items[indexPath.item])
        cell.initSetup()
        cell.setConstraints()
        cell.labelButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // sizeForItemAt
    // collectionView cell(item)의 크리 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemCount: CGFloat = 4
        let line: CGFloat = 5
        let width = collectionView.frame.width / itemCount - minimumInteritemSpace
        let height = collectionView.frame.height / line - minimumLineSpace
        
        if indexPath.item == 16 {
            return CGSize(width: width * 2 + minimumInteritemSpace, height: height)
        }

        return CGSize(width: width, height: height)
    }
    
    // minimumLineSpacingForSectionAt
    // collectionView cell(item)의 행(줄) 별 공간 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpace
    }
    
    // minimumInteritemSpacingForSectionAt
    // collectionView cell(item)의 열(아이템 간) 별 공간 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpace
    }
}
