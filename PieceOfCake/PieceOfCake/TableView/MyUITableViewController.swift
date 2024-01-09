//
//  MyUITableViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit

struct MyData {
    let sectionData: MySection
    var rowData: [String] = []
}

enum MySection: String, CaseIterable {
    case a = "가"
    case b = "나"
    case c = "다"
}

class MyUITableViewController: UIViewController {
    let tableView = UITableView()
    var dataList: [MyData] = [MyData(sectionData: .a, rowData: ["1", "1", "1", "1"]), MyData(sectionData: .b, rowData: ["2", "2", "2", "2", "2"]), MyData(sectionData: .c, rowData: ["3", "3", "3", "3", "3", "3", "3"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        constraint()
        
        // 1. delegate(대리자)를 VC로 설정(필수)
        self.tableView.delegate = self
        
        
        // 2. dataSource를 VC로 설정(필수)
        self.tableView.dataSource = self
        
        
        // 3. Custom Cell 등록 (등록할 cell 클래스, cell identifier 설정)
        self.tableView.register(MyUITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // 헤더푸터 뷰 등록
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        
        
        // 테이블 뷰 셀 구분선 없애기
        self.tableView.separatorStyle = .none
        
        
        // 셀 좌측 수정 버튼 활성화
        self.tableView.setEditing(true, animated: true)
    }
    
    func constraint() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.backgroundColor = .white
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension MyUITableViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    
    // 섹션 헤더 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataList[section].sectionData.rawValue
    }
    
    
    // 섹션 헤더 뷰
    // 참고: https://zeddios.tistory.com/1205
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        
        //iOS 14 이상
        if #available(iOS 14.0, *) {
            var content = header?.defaultContentConfiguration()
            content?.text = dataList[section].sectionData.rawValue
            content?.textProperties.color = .white
            header?.contentConfiguration = content
            
            var contentBackground = header?.backgroundConfiguration
            contentBackground?.backgroundColor = .blue
            header?.backgroundConfiguration = contentBackground
        } else {    //iOS 14 미만
            header?.textLabel?.text = dataList[section].sectionData.rawValue
            header?.textLabel?.textColor = .white
            header?.backgroundColor = .blue
            // header?.detailTextLabel.text = "이런것도 있다."
        }
        return header
    }
    
    
    // 섹션 내 cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].rowData.count
    }
    
    
    // cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyUITableViewCell else { return UITableViewCell() }
        
        cell.constraint()
        cell.title.text = dataList[indexPath.section].rowData[indexPath.row]
        
        return cell
    }
    
    
    // cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 동적 할당이 필요한 경우 - 레이아웃이 정확히 설정되어있어야 한다.
        // return UITableView.automaticDimension
        switch dataList[indexPath.section].sectionData {
        case .a:
            return 30
        default:
            return 50
        }
    }
    
    
    // 수정 가능한 셀 지정
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row > 0 {
            return true
        }
        return false
    }
    
    
    // Delete 스타일 지정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // cell 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataList[indexPath.section].rowData.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            
        }
    }
    
    
    // 이동 가능한 셀 지정
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // 이동 버튼 활성화 (tableView.setEditing이 true로 활성화 되어야함)
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    // 이동 불가 셀 지정
    // func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    //     return proposedDestinationIndexPath
    // }
}
                                    
