//
//  SceneDelegate.swift
//  SelAction
//
//  Created by Michael Frick on 18/01/2020.
//  Copyright © 2020 Glovoapp 23 SL. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  let splitViewController = UISplitViewController()
  let navigationController = UINavigationController(rootViewController: CandidateListViewController())
  
  let detailsNavigationController = UINavigationController(rootViewController: CandidateViewController())
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    splitViewController.viewControllers = [navigationController, detailsNavigationController]
    splitViewController.delegate = self
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = splitViewController
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    
    // Save changes in the application's managed object context when the application transitions to the background.
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
  
  
}


extension SceneDelegate: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {

    detailsNavigationController.pushViewController(vc, animated: true)
    
    return true
  }
  
  func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
    
    let qCv =  QuestionListViewController()
    navigationController.pushViewController(qCv, animated: true)
    
    if let candidate = sender as? Candidate {
      print(candidate.name)
    }
    
    if vc is CandidateViewController {
      detailsNavigationController.setViewControllers([vc], animated: false)
    }
    
    return true
  }
}
