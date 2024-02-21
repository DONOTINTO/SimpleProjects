//
//  UserInfoTable.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/18/24.
//

import UIKit
import RealmSwift

class UserInfoTable: Object {
    @Persisted(primaryKey: true) var UID: ObjectId
    @Persisted var id: String
    @Persisted var password: String
    
    convenience init(id: String, password: String) {
        self.init()
        
        self.id = id
        self.password = password
    }
}
// MARK: Migration
// https://www.mongodb.com/docs/realm/sdk/swift/model-data/change-an-object-model/

// MARK: RelationShip

class Person: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var gender: Bool
    
    // MARK: to - many relationship
    // 한 속성에 다른 Object의 인스턴스 여러 개 매핑할 수 있다.
    // 예시) 사람이 여러개의 펫 인스턴스를 가질 수 있는 관계로 모델링
    @Persisted var pets: List<Pet>
    
    // MARK: EmbeddedObject
    // EmbeddedObject 프로퍼티는 무조건 옵셔널
    @Persisted var address: Address?
    
    convenience init(name: String, gender: Bool) {
        self.init()
        
        self.name = name
        self.gender = gender
    }
    
}

class Pet: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var type: String
    
    // MARK: Inverse Relationship
    @Persisted(originProperty: "pets") var person: LinkingObjects<Person>
    
    convenience init(type: String) {
        self.init()
        
        self.type = type
    }
}

// MARK: EmbeddedObject
class Address: EmbeddedObject {
    @Persisted var street: String?
    @Persisted var city: String?
    @Persisted var country: String?
    @Persisted var postalCode: String?
}
