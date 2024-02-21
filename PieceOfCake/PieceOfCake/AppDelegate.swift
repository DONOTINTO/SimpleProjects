//
//  AppDelegate.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // schemaVersion (속성이 변경될 때 마다 카운트 증가시켜주어야함)
        let configuration = Realm.Configuration(schemaVersion: 3) {
            migration, oldSchemaVersion in
            
            // 옵셔널 프로퍼티 추가 및 프로퍼티 삭제의 경우
            // 별다른 코드를 입력하지 않아도 됨
            if oldSchemaVersion < 1 { }
            
            if oldSchemaVersion < 2 {
                // 프로퍼티 명 변경
                // from : 변경 전
                // to : 변경 후
                migration.renameProperty(onType: Person.className(), from: <#T##String#>, to: <#T##String#>)
            }
            
            
            if oldSchemaVersion < 3 {
                // 프로퍼티 추가
                migration.enumerateObjects(ofType: Person.className()) { oldObject, newObject in
                    
                    guard let newObject else { return }
                    
                    newObject["count"] = 100
                }

            }
        }
        
        // Realm.Configuration.defaultConfiguration = configuration
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

