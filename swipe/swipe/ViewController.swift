//
//  ViewController.swift
//  swipe
//
//  Created by 이중엽 on 12/19/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let horizonScrollView = UIScrollView()
    let verticalScrollView = UIScrollView()
    let horizonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        initSetup()
        configureUI()
        configureStackView()
    }

    func initSetup() {
        self.view.addSubview(horizonScrollView)
        horizonScrollView.addSubview(horizonStackView)
        
        horizonStackView.axis = .horizontal
        horizonStackView.spacing = 0
        
        horizonScrollView.backgroundColor = .black
        horizonStackView.backgroundColor = .blue
    }

    func configureUI() {
        horizonScrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
        }
        
        horizonStackView.snp.makeConstraints {
            //contentLayoutGuide : 콘텐츠를 담을 영역의 제약 가이드라인
            //                      -> 각 Anchor에 대한 오토레이아웃 제약
            
            //frameLayoutGuide : ScrollView Frame 크기 제약 가이드라인
            //                      -> Height와 Width 크기 제약
            
            //네 방향의 Anchor는 contentLG를 바탕으로 제약을 걸어준다.
            //Horizon 스크롤을 할것이기 때문에 height의 제약을 ScrollView의 height와 동일하게 일치시켜준다.
            //좌우로 스와이프할 실제 너비를 width에 지정해준다.
            $0.top.equalTo(self.horizonScrollView.contentLayoutGuide.snp.top)
            $0.leading.equalTo(self.horizonScrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.horizonScrollView.contentLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.horizonScrollView.contentLayoutGuide.snp.bottom)
            
            $0.height.equalTo(self.horizonScrollView.frameLayoutGuide.snp.height)
            $0.width.equalTo(1200)
        }
    }
    
    func configureStackView() {
        let colors: [UIColor] = [.red, .black, .blue, .brown, .darkGray, .green]
        
        colors.forEach {
            let view = UIView()
            view.backgroundColor = $0
            view.snp.makeConstraints {
                $0.width.equalTo(200)
            }
            horizonStackView.addArrangedSubview(view)
        }
    }
}

