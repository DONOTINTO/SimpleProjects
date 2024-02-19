//
//  FileManager++.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/19/24.
//

import UIKit

extension UIViewController {
    
    // 앱 Document에 Image 저장
    func saveImageToDocument(image: UIImage, filename: String) {
        // 앱 도큐먼트 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        print(documentDirectory.path())
        
        // 이미지 저장 경로 및 파일 명 지정
        // 파일 명은 primary key를 이용해서 realm에 column을 추가하지 않아도 됨
        // IOS 16 이상
        let fileURL: URL
        if #available(iOS 16.0, *) {
            fileURL = documentDirectory.appending(path: "\(filename).jpg")
        } else {
            fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        }
        
        // 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // 앱 Document에 Image 불러오기
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // IOS 16 이상
        let fileURL: URL
        if #available(iOS 16.0, *) {
            fileURL = documentDirectory.appending(path: "\(filename).jpg")
        } else {
            fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        }
        
        // 해당 경로에 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
}
