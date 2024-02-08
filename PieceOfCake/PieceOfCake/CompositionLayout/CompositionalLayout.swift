//
//  CompositionalLayout.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/7/24.
//

import UIKit

enum CompositionalLayout: Int, CaseIterable {
    case styleA
    case styleB
    case styleC
    
    static var count: Int {
        return allCases.count
    }
    
    static func create() -> UICollectionViewCompositionalLayout {
        // UICollectionViewCompositionalLayout의 init중 sectionProvider로 생성하여 return
        // sectionProvider의 타입은 UICollectionViewCompositionalLayoutSectionProvider으로 typealias가 되어있다.
        // 그래서 sectionProvider의 타입을 명확히 보면 (Int, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? 클로저 구문이다.
        return UICollectionViewCompositionalLayout { section, environment in
            // 리턴 타입이 NSCollectionLayoutSection?로 옵셔널이기 때문에 nil을 반환해도 된다.
            guard let sectionType = CompositionalLayout(rawValue: section) else { return nil }
            
            switch sectionType {
            case .styleA:
                return createStyleASection()
            case .styleB:
                return createStyleBSection()
            case .styleC:
                return createStyleCSection()
            }
        }
    }
    
    // item -> group -> section 순으로 차례대로 묶인다.
    // 이에 section안에 들어갈 item / group을 생성해주어야 한다.
    static func createStyleASection() -> NSCollectionLayoutSection {
        
        // item과 group의 사이즈를 NSCollectionLayoutSize를 통해 지정해주어야 한다.
        // NSCollectionLayoutSize은 fractional / estimated / absolute로 나누어진다.
        //      fractional - 높이 너비의 비율로 지정한다.
        //      estimated - 높이 너비의 예상 값을 넣어준다. item / group의 높이를 모두 estimated로 지정해주면 높이가 동적으로 할당된다.
        //      absolute - 높이와 너비를 고정시킨다.
        
        // MARK: fractional 적용
        // 주로 비율을 가지게 되는 이미지가 들어간 section에 적용하면 좋을 것 같다.
        let itemSize = NSCollectionLayoutSize(
            // cell item 하나의 너비를 group 너비의 0.5 비율로 잡는다.
            // group 너비와 1 : 0.5 비율이기 때문에 두 개의 열(column)이 된다.
            widthDimension: .fractionalWidth(1.0 / 2.0),
            // cell item 하나의 높이를 group 높이의 1 비율로 잡는다.
            // group 너비의 1 : 1로 한 개의 행(row)이 된다.
            heightDimension: .fractionalHeight(1.0))
        // item layout 객체 생성 - 위 예시에서는 하나의 group에 열 2개 행 1개이므로 총 2개의 item이 들어가게 된다.
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        // 스크롤 방향 및 groupd의 사이즈 / group에 들어가게 될 layout Item을 설정하여 group layout 객체 생성
        // section에 열 1개 행 1개이므로 총 1개의 group이 보여지게 된다.
        // 그 이상의 group은 스크롤 통해 볼 수 있을 것이다.
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section의 header 설정
        // header와 footer 모두 아래와 같이 추가 가능
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // item과 group을 담을 section layout 객체 생성
        // section은 collectionView의 너비와 높이를 따라가게 된다.
        // group은 다시 section의 너비와 높이를 따라가게 된다.
        // item은 다시 group의 너비와 높이를 따라가게 된다.
        // 때문에 group에서 group의 너비를 1 : 0.5 비율을 가지게 된다면 item의 너비를 1:1 비율로 한다해도
        // view에 나타나는 group자체가 2개 이기때문에 사용자에게 보여지기는 item이 2개로 보이게 된다.
        
        // 위 예시 상황에서는 10개의 아이템을 가지게 된다면, 10개의 아이템 / 5개의 그룹이 생성되고 뷰에서는 2열 1행으로 하나의 group만 보이게 될 것이다. 나머지 group은 스크롤을 통해 확인이 가능하다.
        let section = NSCollectionLayoutSection(group: group)
        
        // header와 footer 모두 아래와 같이 추가 가능
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    static func createStyleBSection() -> NSCollectionLayoutSection {
        // MARK: estimated 적용
        // 글의 길이에 따라 높이가 변동할 수 있도록 글자가 들어가는 section에 적용하면 좋을 것 같다.
        
        // 동적인 크기 변화는 특별한 상황이 아니라면 상하 / 좌우 중 한가지에만 적용하는 것이 좋아보인다.
        // 높이의 추정치를 설정해준다.
        // 이를 바탕으로 실제 아이템의 크기에 맞추어 item의 높이가 변한다.
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group도 마찬가지로 estimated를 적용해주어야 동적으로 높이가 변한다.
        // 이는 item이 group에 묶여있기 때문이다.
        // group의 높이가 비율 또는 절대치로 고정되어있는데, item은 높이가 동적으로 설정된다면 서로 충돌할 것이다.
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    static func createStyleCSection() -> NSCollectionLayoutSection {
        // MARK: absolute 적용
        // 반드시 크기가 고정이어야 하는 section에 적용하면 좋을 것 같다.
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
