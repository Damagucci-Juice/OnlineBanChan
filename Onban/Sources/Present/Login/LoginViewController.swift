//
//  LoginViewController.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import AuthenticationServices
import SnapKit

final class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    private let appleLoginButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grey4
        appleLoginButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        
        self.view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let result: String = """
                                User id is \(userIdentifier)
                                Full Name is \(String(describing: fullName))
                                Email id is \(String(describing: email))
                                """
            UserDefaults.standard.set(userIdentifier, forKey: "userID")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func checkCredentialState() {
        guard let userID = UserDefaults.standard.object(forKey: "userID") as? String else { return }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) {  (credentialState, _) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("approved")
            case .revoked:
                // The Apple ID credential is revoked.
                print("rejected")
            case .notFound:
                // No credential was found, so show the sign-in UI.
                print("re-login")
            default:
                print("default session")
            }
        }
    }
}
