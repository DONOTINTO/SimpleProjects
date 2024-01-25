//
//  CLMapKitViewController.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/25/24.
//

import UIKit
import CoreLocation
import MapKit

// 위치 권한 설정
// Info.plist > 'Privacy - Location When In Use Usage Description' Key 추가

class CLMapKitViewController: UIViewController {
    
    // 맵 뷰 생성
    let mapView: MKMapView = MKMapView()
    
    // CL 매니저 생성
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Delegate 설정
        // Delegate 설정 시 locationManagerDidChangeAuthorization가 호출되기 때문에 설정 위치 주의
        locationManager.delegate = self
        checkDeviceLocationAuthorization()
    }
    
    // 1. 사용자 기기의 '위치 서비스' 활성화 여부 판단
    // 2. 어플리케이션의 현재 위치 권한 '상태' 별 설정 요청
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            // 기기의 '위치 서비스' 활성화 여부 판단
            if CLLocationManager.locationServicesEnabled() {
                
                let appAuthorizationStatus: CLAuthorizationStatus
                
                // iOS 14 이상
                if #available(iOS 14.0, *) {
                    appAuthorizationStatus = self.locationManager.authorizationStatus
                    // iOS 14 미만
                } else {
                    appAuthorizationStatus = CLLocationManager.authorizationStatus()
                }
                
                // 어플리케이션의 현재 위치 권한 '상태' 별 설정 요청
                self.checkAppLocationAuthorizationStatus(status: appAuthorizationStatus)
                
            } else {
                print("'설정 > 개인정보 보호 및 보안 > 위치 서비스'를 켜주시기 바랍니다.")
            }
        }
    }
    
    func checkAppLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        // 아직 권한 설정 전
        case .notDetermined:
            print("here")
            // 권한 요청 전 desiredAccuracy 설정
            // kCLLocationAccuracyBest - 현재 위치를 가장 정확하게 요청
            // kCLLocationAccuracyKilometer - 현재 위치를 대략적인 키로미터 반경으로 요청
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 위치 권한 요청
            locationManager.requestWhenInUseAuthorization()
            
        // 자녀 보호 기능 등으로 앱의 위치 권한 상태를 변경할 수 없는 경우
        case .restricted:
            print("restricted")
            
        // 권한을 거절한 경우
        case .denied:
            
            showAlert(title: "위치 권한 설정", msg: "위치 서비스를 이용하실 수 없습니다. 위치 서비스를 켜주시기 바랍니다.", okTitle: "설정 페이지 바로가기") {
                
                // 설정 페이지 경로
                guard let setting = URL(string: UIApplication.openSettingsURLString) else { return }
                
                // 설정 페이지 열기
                UIApplication.shared.open(setting)
            }
            
        // 권한을 '항상' 허용한 경우
        case .authorizedAlways:
            
            // 위치값 한번만 업데이트
            locationManager.requestLocation()
            
            // 위치값 업데이트 - 계속 업데이트 할게 아니라면 특정 부분에서 stop해줘야 함
            // locationManager.startUpdatingLocation()
            
        // 권한을 '어플을 사용하는 동안'으로 허용한 경우
        case .authorizedWhenInUse:
            
            // 위치값 한번만 업데이트
            locationManager.requestLocation()
            
            // 위치값 업데이트 - 계속 업데이트 할게 아니라면 특정 부분에서 stop해줘야 함
            // locationManager.startUpdatingLocation()
            
        // 현재 사용하지 않는 코드
        case .authorized:
            print("authorized")
        
        // @unknown 앞으로 추가될 여지가 있음을 알려줌
        @unknown default:
            print("default")
        }
    }
    
}

// Delegate 프로토콜 채택
extension CLMapKitViewController: CLLocationManagerDelegate {
    // 사용자 위치 정보 업데이트 성공 시 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // MARK: 지도의 Center를 현재 위치로 변경
        
        // 현재 좌표
        guard let curCoordinate = locations.last?.coordinate else { return }
        
        let center = CLLocationCoordinate2D(latitude: curCoordinate.latitude, longitude: curCoordinate.longitude)
        
        let curRegion = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        // MKMapView의 Center를 현재 위치로 설정
        mapView.setRegion(curRegion, animated: true)
        
        // MARK: 현재 위치에 Annotation 나타내기
        let curAnnotation = MKPointAnnotation()
        curAnnotation.coordinate = curCoordinate
        curAnnotation.title = "현재 위치"
        
        mapView.addAnnotation(curAnnotation)
    }
    
    // 사용자 위치 정보 업데이트 실패 시 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 정보 호출 실패")
    }
    
    // 1. 사용자 위치 정보 권한 상태 변경 시 호출
    // 2. CLLocationManager 인스턴스 생성 시 호출
    // 네비게이션, 탭바에 embed되어있다면 2번이 무시됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}

extension CLMapKitViewController {
    func configureUI() {
        self.view.addSubview(mapView)
        self.view.backgroundColor = .white
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
