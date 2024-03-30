//
//  ImagePickerVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/19/24.
//

import UIKit
import SnapKit

class ImagePickerVC: UIViewController {
    
    var imagePickerButton = UIButton()
    var pickerImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @objc func imagePickerButtonClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
}

extension ImagePickerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // image Picker를 cancel했을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // 사진 선택 후
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickerImageView.image = pickedImage
            
            // 앱 Document에 이미지 저장
            saveImageToDocument(image: pickedImage, filename: "primary ObjectID로 저장")
        }
        
        dismiss(animated: true)
    }
}


extension ImagePickerVC {
    func configureHierarchy() {
        [imagePickerButton, pickerImageView].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        imagePickerButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.horizontalEdges.equalTo(view).inset(10)
            $0.height.equalTo(44)
        }
        
        pickerImageView.snp.makeConstraints {
            $0.top.equalTo(imagePickerButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view).inset(10)
            $0.height.equalTo(pickerImageView.snp.width)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        imagePickerButton.setTitle("사진첩 바로가기", for: .normal)
        imagePickerButton.setTitleColor(.white, for: .normal)
        imagePickerButton.backgroundColor = .black
     
        pickerImageView.backgroundColor = .black
        
        imagePickerButton.addTarget(self, action: #selector(imagePickerButtonClicked), for: .touchUpInside)
    }
}
