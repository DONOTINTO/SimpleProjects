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
    
    // Create
    func write<T: Object>(_ item: T) {
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
    
    // func fetchByWhere<T: Object>(type: T.Type, value: Any) -> Results<T> {
    //     let list = realm.objects(type).where {
    //         $0.value == value
    //     }
    //     
    //     return list
    // }
    
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
