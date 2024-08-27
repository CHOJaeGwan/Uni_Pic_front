//
//  AppleAuthVM.swift
//  UNI_PIC
//
//  Created by 조재관 on 5/9/24.
//

import Foundation
import AuthenticationServices
import _AuthenticationServices_SwiftUI
import SwiftUI

class AppleAuthVM: ObservableObject {

    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName : String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    @Published var isLoggedIn : Bool = false
    
    func handleAppleLogin() {
        SignInWithAppleButton(.continue){request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            switch result{
            case .success(let auth):
                switch auth.credential{
                case let credential as ASAuthorizationAppleIDCredential:
                    let userId = credential.user
                    let email = credential.email
                    let firtName  = credential.fullName?.givenName
                    let lastName = credential.fullName?.familyName
                    if  let authorizationCode = credential.authorizationCode,
                        let identityToken = credential.identityToken,
                        let authCodeString = String(data: authorizationCode, encoding: .utf8),
                        let identityTokenString = String(data: identityToken, encoding: .utf8){
                        print("identityToken: ", identityTokenString)
                        print("AuthCode: ", authCodeString)
                    }
                    
                    self.email = email ?? ""
                    self.userId = userId
                    self.firstName = firtName ?? ""
                    self.lastName = lastName ?? ""
                    self.isLoggedIn = true
                default: break
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
