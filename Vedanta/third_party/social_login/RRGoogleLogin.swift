//
//  RRGoogleLogin.swift
//  RRSocialLogin
//
//  Created by Rahul Mayani on 20/12/19.
//  Copyright © 2019 RR. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import RxSwift

class RRGoogleLogin: UIViewController {
    
    // MARK: - Variable -
    static let shared = RRGoogleLogin()
    
    open var googleUserDetails: PublishSubject<SocialUserDetails> = PublishSubject()
    
    // MARK: - Others -
    func googleSignIn(viewController: UIViewController) {
        /*GIDSignIn.sharedInstance.delegate = self
        GIDSignIn.sharedInstance.presentingViewController = viewController
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance.signIn()*/
    }
    
    static func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue ||
               (error as NSError).code == GIDSignInError.canceled.rawValue ||
               (error as NSError).code == GIDSignInError.unknown.rawValue {
               debugPrint("The user has not signed in before or they have since signed out.")
            } else {
               googleUserDetails.onError(error)
            }
        } else {
            var imageURL: String = ""
            if let profilePic = user.profile!.imageURL(withDimension: 200) {
                imageURL = profilePic.absoluteString
            }
            let user = SocialUserDetails.init(userId: user.userID!, type: .google, name: user.profile!.name, email: user.profile!.email, profilePic: imageURL)
            
            googleUserDetails.onNext(user)
            
            
        }
    }
    
}
