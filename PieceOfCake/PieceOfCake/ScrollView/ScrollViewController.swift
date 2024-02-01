//
//  ScrollViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/1/24.
//

import UIKit
import SnapKit

class ScrollViewController: UIViewController {

    // 1. 스크롤 뷰 생성
    let scrollView = UIScrollView()
    
    // 2. 스크롤 뷰의 내부 컨텐츠 뷰 생성
    // 스크롤 뷰 안에 들어가는 서브 뷰들은 Content View 내부로 들어간다.
    // ScrollView
    //      - ContentView
    //          - 그 외 뷰
    let contentView = UIView()
    
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    let fourthView = UIView()
    let fifthView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰에는 scrollView 추가
        self.view.addSubview(scrollView)
        
        // scrollView에는 contentView 추가
        self.scrollView.addSubview(contentView)
        
        // 스크롤로 보여줄 뷰들을 contentView에 모두 추가
        [firstView, secondView, thirdView, fourthView, fifthView].forEach {
            self.contentView.addSubview($0)
        }
        
        // MARK: 레이아웃 구성
        
        // 1. 스크롤 뷰를 view의 edges에 모두 동일하게 추가
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 2. contentView의 edges를 scrollView의 contentLayoutGuide에 맞추기
        // 3. 가로 스크롤일 경우 height를 scrollView의 FrameLayoutGuide의 height로 고정
        // 4. 세로 스크롤의 경우 width를 scrollView의 FrameLayoutGuide의 width로 고정
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        // 나머지 뷰들은 contentView에 맞추기
        firstView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(contentView)
            $0.height.equalTo(300)
        }
        
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(300)
        }
        
        thirdView.snp.makeConstraints {
            $0.top.equalTo(secondView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(300)
        }
        
        fourthView.snp.makeConstraints {
            $0.top.equalTo(thirdView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(300)
        }
        
        // 맨 하단 뷰는 bottom을 통해 끝을 알려줘야함
        // 시작과 끝을 contentView가 알고 각 subView들의 높이(세로 스크롤)를 알게되면 스크롤 작동
        // 스크롤이 안된다면 위 설정이 명확히 됐는지 체크해보아야 함
        fifthView.snp.makeConstraints {
            $0.top.equalTo(fourthView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(300)
            $0.bottom.equalTo(contentView)
        }
        
        
        firstView.backgroundColor = .systemRed
        secondView.backgroundColor = .systemYellow
        thirdView.backgroundColor = .systemOrange
        fourthView.backgroundColor = .systemGreen
        fifthView.backgroundColor = .systemBlue
    }

}
