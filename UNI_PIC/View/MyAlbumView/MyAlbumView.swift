import SwiftUI
import Alamofire

struct MyAlbumView: View {
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    @AppStorage("userId") var userId: String = ""
    @State private var alertType: AlertType? = nil
    @State private var isAccountDeletionPromptShown: Bool = false
    @State private var navigateToSignIn: Bool = false

    enum AlertType: Identifiable {
        case loggedOut
        case signOut
        
        var id: UUID {
            UUID()
        }
        
        var title: Text {
            switch self {
            case .loggedOut:
                return Text("로그 아웃")
            case .signOut:
                return Text("회원 탈퇴")
            }
        }
        
        var message: Text {
            switch self {
            case .loggedOut:
                return Text("로그 아웃 되었습니다.")
            case .signOut:
                return Text("회원 탈퇴 되었습니다.")
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    Color("NeutralColor_800")
                    Text("UNI Gallery")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.top, 40)
                }
                .frame(height: CGFloat.screenHeight * 0.15)
                .ignoresSafeArea()
                .vTop()
                .padding(.bottom)
                VStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color("NeutralColor_200"))
                        .padding()
                    
                    Text("User")
                        .font(.title3)
                }
                .vTop()
                .padding(.top, CGFloat.screenHeight * 0.2)
                HStack {
                    Button(action: logout) {
                        Text("로그 아웃")
                            .foregroundStyle(LinearGradientStyle.colorGradient)
                            .padding()
                            .background(ColorButtonComponent())
                            .cornerRadius(10)
                    }
                    Button(action: {
                        isAccountDeletionPromptShown = true
                    }) {
                        Text("회원 탈퇴")
                            .foregroundColor(.red)
                            .padding()
                            .background(ColorButtonComponent())
                            .cornerRadius(10)
                    }
                }
                .vCenter()
                .padding(.top, 40)
                CustomActionSheetView(
                    isPresented: $isAccountDeletionPromptShown,
                    title: "정말 회원 탈퇴 하시겠습니까?",
                    message: "탈퇴시 회원님과 관련된 모든 정보는 없어집니다.",
                    destructiveAction: deleteAccount
                )
            }
            .alert(item: $alertType) { alertType in
                Alert(
                    title: alertType.title,
                    message: alertType.message,
                    dismissButton: .default(Text("확인")) {
                        handlePostLogout()
                    }
                )
            }
            .fullScreenCover(isPresented: $navigateToSignIn) {
                SignInView()
            }
        }
    }

    func logout() {
        let url = "http://3.39.13.136:3000/user/logout"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, method: .delete, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 200 {
                        accessToken = ""
                        refreshToken = ""
                        alertType = .loggedOut
                    } else {
                        print("Logout failed with status code: \(httpResponse.statusCode)")
                    }
                }
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(responseString)")
                }
            case .failure(let error):
                print("Logout failed with error: \(error)")
            }
        }
    }

    func deleteAccount() {
        let url = "http://3.39.13.136:3000/user/signout"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, method: .delete, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 200 {
                        accessToken = ""
                        refreshToken = ""
                        alertType = .signOut
                    } else {
                        print("Account deletion failed with status code: \(httpResponse.statusCode)")
                    }
                }
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(responseString)")
                }
            case .failure(let error):
                print("Account deletion failed with error: \(error)")
            }
        }
    }

    func handlePostLogout() {
        navigateToSignIn = true
    }
}

struct MyAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        MyAlbumView()
    }
}
