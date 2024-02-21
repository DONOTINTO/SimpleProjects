//
//  UserDefaultManager.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/25/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    private let ud = UserDefaults.standard
    private let isLogin = "isLogin"
    private let sampleArray = "sampleArray"
    
    // Bool 값 UserDefaults에 저장
    func setIsLogin(value: Bool) {
        ud.set(value, forKey: UserDefaultsManager.shared.isLogin)
    }
    
    // Int Array 값 UserDefaults에 저장
    func setSampleArray(value: [Int]) {
        ud.set(value, forKey: UserDefaultsManager.shared.sampleArray)
    }
    
    // UserDefaults에 저장 값(isLogin) 호출
    func getIsLogin() -> Bool {
        return ud.bool(forKey: UserDefaultsManager.shared.isLogin)
    }
    
    // UserDefaults에 저장 값(sampleArray) 호출
    func getSampleArray() -> [Int] {
        return ud.array(forKey: UserDefaultsManager.shared.sampleArray) as? [Int] ?? []
    }
}
