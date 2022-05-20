//
//  SceneDelegate.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }

    private func createCrossfadeNC() -> UINavigationController {
        let crossfadeVC = CrossfadeVC(player: CFAudioPlayer())
        crossfadeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage.init(systemName: "play.fill"), tag: 0)

        return UINavigationController(rootViewController: crossfadeVC)
    }

    private func createAudioListVC() -> UIViewController {
        let audioListVC = AudioListVC(firstOrSecond: true)
        audioListVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "music.note.list"), tag: 1)
        return audioListVC
    }

    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemOrange
        tabbar.viewControllers = [createCrossfadeNC(),
                                  createAudioListVC()]

        return tabbar
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

