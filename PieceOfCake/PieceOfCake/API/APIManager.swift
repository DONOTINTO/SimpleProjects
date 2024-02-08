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

//=====================================================
// Naver Shopping API 호출 Manager - Singleton
//=====================================================
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
    
    func callRequestNaverShoppingByURLSession(keyword: String, start: Int, display: Int, sortType: SortType, completion: @escaping (NaverSearch) -> Void) {
        
        // 한글 인코딩
        let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // URL 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openapi.naver.com"
        urlComponents.path = "/v1/search/shop.json"
        
        // 쿼리 설정
        let queryItem = URLQueryItem(name: "query", value: query)
        let displayItem = URLQueryItem(name: "display", value: "\(display)")
        let startItem = URLQueryItem(name: "start", value: "\(start)")
        let sortItem = URLQueryItem(name: "sort", value: sortType.param)
        
        urlComponents.queryItems = [queryItem, displayItem, startItem, sortItem]
        
        // URL Request 생성
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method(통신 방식) 설정 - GET / POST
        urlRequest.httpMethod = "GET"
        
        // URL Header 세팅
        urlRequest.setValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        
        // URL Session 생성
        let urlSession = URLSession.shared
        
        // 요청 수행
        urlSession.dataTask(with: urlRequest) {data, response, error in
            if let error { return }
            guard let data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            
            // JSON 형태를 디코딩하여 NaverSearch(struct) 형태로 바꿈
            do {
                let userResponse = try JSONDecoder().decode(NaverSearch.self, from: data)
                dump(userResponse)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    //=====================================================
    // Naver Shopping API 호출 - Meta Type 버전
    //=====================================================
    func anyTypeFetch<T: Decodable>(type: T.Type, input: String ,completionHandler: @escaping (T?, Error?) -> Void) {
        // 한글 인코딩
        let query = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // URL 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openapi.naver.com"
        urlComponents.path = "/v1/search/shop.json"
        
        // 쿼리 설정
        let queryItem = URLQueryItem(name: "query", value: query)
        let displayItem = URLQueryItem(name: "display", value: "30")
        let startItem = URLQueryItem(name: "start", value: "0")
        
        urlComponents.queryItems = [queryItem, displayItem, startItem]
        
        // URL Request 생성
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method(통신 방식) 설정 - GET / POST
        urlRequest.httpMethod = "GET"
        
        // URL Header 세팅
        urlRequest.setValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        
        // URL Session 생성
        let urlSession = URLSession.shared
        
        // 요청 수행
        urlSession.dataTask(with: urlRequest) {data, response, error in
            if let error {
                completionHandler(nil, error)
                return
            }
            guard let data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            
            // JSON 형태를 디코딩하여 NaverSearch(struct) 형태로 바꿈
            do {
                let userResponse = try JSONDecoder().decode(type.self, from: data)
                completionHandler(userResponse, nil)
            } catch {
                completionHandler(nil, error)
                print(error.localizedDescription)
            }
            
        }.resume()
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
