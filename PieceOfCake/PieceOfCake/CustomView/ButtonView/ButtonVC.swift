//
//  ButtonVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit

class ButtonVC: UIViewController {
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        constraint()
        designButton()
    }

    func constraint() {
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        // button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        // button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:  -20).isActive = true
        // button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func designButton() {
        //Button Configuration (ios 15 이상부터)
        //configuration을 통해 button의 구성을 조정할 수 있음
        //struct type이기 때문에 내부 값을 변경하기 위해서는 var로 생성해야됨
        //기본 메소드, 프로퍼티보다는 우선순위가 낮음
        
        //plain / gray / tinted / filled
        var buttonConfiguration = UIButton.Configuration.plain()
        
        //이미지 설정 - UIImage는 View 속성인 tintColor가 없기 때문에 다음과 같이 설정해줘야한다.
        buttonConfiguration.image = UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        //타이틀 설정
        buttonConfiguration.title = "버튼 제목 설정"
        
        //서브타이틀 설정
        buttonConfiguration.subtitle = "서브 제목 설정"
        
        //이미지, 타이틀, 서브타이틀 색상 설정
        buttonConfiguration.baseForegroundColor = .black
        
        //배경 색상 설정 - 적용대상(gray/tinted/filled)
        buttonConfiguration.baseBackgroundColor = .systemCyan
        
        //버튼 배경 색상 설정 - 적용대상(모든 style)
        buttonConfiguration.background.backgroundColor = .orange
        
        //이미지 위치 설정
        buttonConfiguration.imagePlacement = .trailing
        
        //이미지 패딩
        buttonConfiguration.imagePadding = 10
        
        //타이틀과 서브타이틀 패딩
        buttonConfiguration.titlePadding = 10
        
        //타이틀과 서브타이틀 정렬
        buttonConfiguration.titleAlignment = .center
        
        //height 제약을 걸지 않았다면 버튼 사이즈 결정
        buttonConfiguration.buttonSize = .small
        
        //버튼의 마진 조절
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        //버튼 테투리 색상 설정
        buttonConfiguration.background.strokeColor = .black
        
        //버튼 테투리 두께 설정
        buttonConfiguration.background.strokeWidth = 10
        
        //버튼 모서리 반경 제어
        buttonConfiguration.background.cornerRadius = 3
        
        //버튼 모서리 스타일 - 기본값 .dynamic
        //dynamic 제외 cornerRadius 무시
        buttonConfiguration.cornerStyle = .dynamic
        
        //버튼 로딩(?) Indicator 노출여부
        buttonConfiguration.showsActivityIndicator = false
        
        //버튼의 configuration을 업데이트하는 클로저
        let buttonConfigurationHandler: UIButton.ConfigurationUpdateHandler = { myButton in
            if case .selected = myButton.state {
                myButton.configuration?.showsActivityIndicator = true
            } else {
                myButton.configuration?.showsActivityIndicator = false
            }
        }

        //버튼 configuration 설정
        button.configuration = buttonConfiguration
        
        //버튼 configurationHandler 설정
        button.configurationUpdateHandler = buttonConfigurationHandler
        
        //버튼 action 추가
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
