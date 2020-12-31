//
//  SceneDelegate.swift
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		let vc = DictionaryViewController()
		let nc = UINavigationController(rootViewController: vc)
		nc.navigationBar.tintColor = .white
		
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			vc.title = NSLocalizedString("Dari", comment: "")
			window.rootViewController = nc
			window.makeKeyAndVisible()
			self.window = window
		}
	}

}

