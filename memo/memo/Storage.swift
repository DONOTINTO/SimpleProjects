//
//  Storage.swift
//  memo
//
//  Created by 이중엽 on 12/18/23.
//

import Foundation

class Storage {
    static let shared = Storage()
    
    private var text: [String] = []
    
    private init() { }
    
    func addData(_ text: String?) {
        guard let data = text else { return }
        if data == "" { return }
        Storage.shared.text.append(data)
    }
    
    func count() -> Int {
        return Storage.shared.text.count
    }
    
    func getData(idx: Int) -> String {
        return Storage.shared.text[idx]
    }
    
    func remove(idx: Int) {
        Storage.shared.text.remove(at: idx)
    }
}
