//
//  APIManager.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/22/24.
//

import Foundation
import Alamofire

enum SortType: Int {
    case similar
    case date
    case descending // 가격 높은 순 - 내림차순
    case ascending  // 가격 낮은 순 - 오름차순
    
    var title: String {
        switch self {
        case .similar:
            return "정확도"
        case .date:
            return "날짜순"
        case .descending:
            return "가격높은순"
        case .ascending:
            return "가격낮은순"
        }
    }
    var param: String {
        switch self {
        case .similar:
            return "sim"
        case .date:
            return "date"
        case .descending:
            return "dsc"
        case .ascending:
            return "asc"
        }
    }
}

class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    
    //=====================================================
    // Naver Shopping API 호출 - Alamofire 버전
    //=====================================================
    // 클로저가 함수의 인자로 전달됐을 때, 함수의 실행이 종료된 후 실행되는 클로저
    func callRequestNaverShoppingByAlamofire(keyword: String, start: Int, display: Int, sortType: SortType, completion: @escaping (NaverSearch) -> Void) {
        // 한글 인코딩
        let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // 호출 URL
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)"
        
        // 파라미터(쿼리 구성)
        let param: Parameters = ["display": display, "start": start, "sort": sortType.param]
        
        // 헤더 구성
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.clientID, "X-Naver-Client-Secret": APIKey.clientSecret]
        
        // API 호출(요청)
        AF.request(url, method: .get, parameters: param, headers: header).responseDecodable(of: NaverSearch.self) { response in
            switch response.result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//=====================================================
// Naver Shopping API Data Decoder - Json to Struct
//=====================================================
struct NaverSearch: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [Items]
}

struct Items: Decodable {
    let title: String
    let link: String
    let image: String
    let price: String
    let productId: String
    let mallName: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, image
        case price = "lprice"
        case productId, mallName
    }
}
