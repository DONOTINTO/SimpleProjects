//
//  SceneDelegate.swift
//  PieceOfCake
//
//  Created by 이중엽 on 1/8/24.
//

import UIKit

enum RootView {
    case rootVC
    case naviVC
    case tabbarVC
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if #available(iOS 15, *) {
            // MARK: Navigation bar appearance
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
            navigationBarAppearance.backgroundColor = UIColor.clear
            // 일반 네이게이션 바 appearance settings
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            // 랜드스케이프 되었을 때 네이게이션 바 appearance settings
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            // 스크롤 엣지가 닿았을 때 네이게이션 바 appearance settings
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            // MARK: Tab bar appearance
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.black
            // 스크롤 엣지가 닿았을 때 탭바 appearance settings
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            // 일반 탭바 appearance settings
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        
        // MARK: 스토리보드 없이 초기 화면 띄우기
        
        // 케이스 별로 VC 띄우기
        let rootVCCase = RootView.naviVC
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        switch rootVCCase {
        case .rootVC:
            // 1. 일반 VC로 연결
            let rootVC = SceneDelegateViewController()
            window.rootViewController = rootVC
            
        case .naviVC:
            // 2. 네비게이션 VC로 연결
            let naviRootVC = SceneDelegateViewController()
            let naviVC = UINavigationController(rootViewController: naviRootVC)
            window.rootViewController = naviVC
            
        case .tabbarVC:
            // 3. 탭바 VC로 연결
            let tabbarItemVC = SceneDelegateViewController()
            let tabbarVC = UITabBarController()
            tabbarVC.setViewControllers([tabbarItemVC], animated: true)
            window.rootViewController = tabbarVC
        }
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

