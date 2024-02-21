//
//  RealmManager.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/15/24.
//

import UIKit
import RealmSwift

class RealmManager {
    
    private var realm: Realm {
        let realm = try! Realm()
        return realm
    }
    
    func checkRealmVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print(version)
        } catch {
            print(error)
        }
    }
    
    // Create
    func add<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Read
    func fetch<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    // Read - Object ID로 Object 가져오기
    func fetchByObjectID<T: Object>(type: T.Type ,_ id: ObjectId) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    // Read - Filter를 사용해도 Result<T>로 반환 가능
    func fetchByPredicate<T: Object>(type: T.Type, date: Date) -> Results<T> {
        
        // 오늘 날짜 Date만 선별
        let startDate = Calendar.current.startOfDay(for: Date())
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? Date()
        
        // column명 사용해야함 / %@
        let predicate = NSPredicate(format: "칼럼명 >= %@ && 칼럼명 < %@", startDate as NSDate, endOfDate as NSDate)
        
        let list = realm.objects(type.self).filter(predicate)
        
        return list
    }
    
    // Delete
    func delete<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Update - Object ID로 value 값 변경하기
    func updateByID<T: Object>(_ type: T.Type, id: ObjectId, value: Any) {
        do {
            try realm.write {
                realm.create(type,
                             value: [
                                "id": id,
                                "value": value
                             ],
                             update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
