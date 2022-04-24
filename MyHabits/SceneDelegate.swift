//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        setAppearance()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CreateRootViewController()
        window.makeKeyAndVisible()
        self.window = window
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

extension SceneDelegate {

    private func CreateRootViewController() -> UIViewController {

        let habitsViewController = HabitsViewController()
        habitsViewController.title = "Сегодня"
        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки",
                                                       image: UIImage(named: "habitsIcon"),
                                                       tag: 0)

        let infoViewController = InfoViewController()
        infoViewController.tabBarItem = UITabBarItem(title: "Информация",
                                                     image: UIImage(systemName: "info.circle.fill"),
                                                     tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .myHabitsColor(.mainBackground)

        tabBarController.tabBar.backgroundColor = .myHabitsColor(.tabBarBackground)
        tabBarController.tabBar.tintColor = .myHabitsColor(.purple)

        tabBarController.setViewControllers(
            [UINavigationController(rootViewController: habitsViewController),
             UINavigationController(rootViewController: infoViewController)],
            animated: true)

        return tabBarController
    }

    private func setAppearance() {
        let appearance = UINavigationBarAppearance()

        //largeTitleTextAttributes
        let largeTitleParagraphStyle = NSMutableParagraphStyle()
        largeTitleParagraphStyle.lineHeightMultiple = 0.99

        appearance.largeTitleTextAttributes = [
            .font: Fonts.SFProDisplayBold34,
            .kern: 0.41,
            .paragraphStyle: largeTitleParagraphStyle
        ]

        //titleTextAttributes
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.lineHeightMultiple = 1.08

        appearance.titleTextAttributes = [
            .font: Fonts.SFProTextSemibold17,
            .kern: -0.41,
            .paragraphStyle: titleParagraphStyle
        ]

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
