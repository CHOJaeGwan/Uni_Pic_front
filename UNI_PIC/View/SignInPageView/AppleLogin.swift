import SwiftUI
import AuthenticationServices
import Alamofire

struct APIResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

struct AppleLogin: View {
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    @AppStorage("identityTokenString") var identityTokenString: String = ""
    @AppStorage("authorizationCodeString") var authorizationCodeString: String = ""
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    @Binding var isLoggedIn: Bool

    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            handleAuthorization(result: result)
        }
        .frame(maxWidth: 375)
        .frame(height: 50)
        .signInWithAppleButtonStyle(.whiteOutline)
        .padding()
    }
    
    func handleAuthorization(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential else { return }
            let userId = credential.user
            let email = credential.email
            let firstName = credential.fullName?.givenName
            let lastName = credential.fullName?.familyName
            
            if let authorizationCode = credential.authorizationCode,
               let identityToken = credential.identityToken,
               let authorizationCodeString = String(data: authorizationCode, encoding: .utf8),
               let identityTokenString = String(data: identityToken, encoding: .utf8) {
                // 저장할 정보 업데이트
                self.email = email ?? ""
                self.userId = userId
                self.identityTokenString = identityTokenString
                self.authorizationCodeString = authorizationCodeString
                self.firstName = firstName ?? ""
                self.lastName = lastName ?? ""
                
                print("Email: \(self.email)")
                print("User ID: \(self.userId)")
                print("First Name: \(self.firstName)")
                print("Last Name: \(self.lastName)")
                print("identityTokenString:  \(self.identityTokenString)")
                print("authorizationCodeString: \(self.authorizationCodeString)")
                // 로그인 상태 변경
                isLoggedIn = true
                
                // API로 이메일 전송
                sendCodeToAPI(authorizationCode: authorizationCodeString)
                // sendEmailToAPI(identityToken: identityTokenString)
            } else {
                print("Error: Authorization code or identity token is missing.")
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
    
//    func sendEmailToAPI(identityToken: String) {
//        let url = "http://3.39.13.136:3000/user/login/apple"
//        let parameters: [String: String] = ["code": identityToken]
//        
//        print("URL: \(url)")
//        print("Headers: \(parameters)")
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: APIResponse.self) { response in
//                switch response.result {
//                case .success(let value):
//                    print("Access Token: \(value.accessToken)")
//                    print("Refresh Token: \(value.refreshToken)")
//                    self.accessToken = value.accessToken
//                    self.refreshToken = value.refreshToken
//                case .failure(let error):
//                    print("API request failed: \(error.localizedDescription)")
//                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                        print("Server Response: \(utf8Text)")
//                    }
//                }
//            }
//    }
    
    func sendCodeToAPI(authorizationCode: String) {
        let url = "http://3.39.13.136:3000/user/login"
        let parameters: [String: String] = ["code": authorizationCode]
        
        print("URL: \(url)")
        print("Headers: \(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: APIResponse.self) { response in
                switch response.result {
                case .success(let value):
                    print("Access Token: \(value.accessToken)")
                    print("Refresh Token: \(value.refreshToken)")
                    self.accessToken = value.accessToken
                    self.refreshToken = value.refreshToken
                   // revokeAppleToken()
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Server Response: \(utf8Text)")
                    }
                }
            }
    }
    
//    func revokeAppleToken() {
//        let provider = ASAuthorizationAppleIDProvider()
//        provider.getCredentialState(forUserID: userId) { (credentialState, error) in
//            switch credentialState {
//            case .revoked:
//                print("Apple ID credential revoked.")
//            case .authorized:
//                print("Apple ID credential is still authorized.")
//            case .notFound:
//                print("Apple ID credential not found.")
//            default:
//                break
//            }
//        }
//    }
}

struct AppleLogin_Previews: PreviewProvider {
    static var previews: some View {
        AppleLogin(isLoggedIn: .constant(false))
    }
}
