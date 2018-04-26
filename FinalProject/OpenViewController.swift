//
//  OpenViewController.swift
//  FinalProject
//
//  Created by Tiffany on 4/25/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import UIKit


class OpenViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    func signIn(){
//        let providers: [FUIAuthProvider] = [
//            FUIGoogleAuth()
//            ]
//        if authUI.auth?.currentUser == nil{
//            self.authUI?.providers = providers
//            present(authUI.authViewController(), animated: true, completion: nil)
//        }else{
//
//        }
//    }
    
}
//
//extension OpenViewController: FUIAuthDelegate{
//    
//    func application(_ app: UIApplication, open url: URL,
//                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
//        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//            return true
//        }
//        // other URL handling goes here.
//        return false
//    }
//    
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//        if user == user{
//            print("user signed in!")
//        }
//        
//    }
//}
