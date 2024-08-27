//
//  EditVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

// 카메라 권한 요청
//func requestCameraPermission() {
//    AVCaptureDevice.requestAccess(for: .video) { granted in
//        if granted{
//            print("Camera: 권한 허용")
//        }else{
//            print("Camera: 권한 거부")
//        }
//    }
//}
//
//// 앨범 권한 요청
//func requestPhotoLibraryPermission() {
//    PHPhotoLibrary.requestAuthorization { status in
//        switch status{
//            case .authorized:
//                print("Album: 권한 허용")
//            case .denied:
//                print("Album: 권한 거부")
//            case .restricted, .notDetermined:
//                print("Album: 선택하지 않음")
//            default:
//                break
//            }
//    }
//}

import SwiftUI
import AVFoundation
import Photos
import Alamofire

struct RemainingCountResponse: Decodable {
    let remainingCount: Int
}

struct EditView: View {
    @State private var isPressed: Bool = false
    @State private var checkPermissions: Bool = false
    @State private var checkAgree: Bool = false
    @State private var showDetails = false
    @State private var isLoading: Bool = true
    @State private var retryCount: Int = 0
    @State private var arePermissionsGranted: Bool = false // 권한 체크 변수 추가
    @EnvironmentObject var remainingCountStore: RemainingCountStore
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    @Binding var isShowingTabBar: Bool
    let maxRetryCount = 5
    let retryDelay: TimeInterval = 1.0

    let willEnterForeground = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
        .makeConnectable()
        .autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .scaleEffect(1.5)
                } else {
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            ZStack {
                                Image("EditBanner")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height * 480 / 852)
                                    .clipped()
                                    .overlay(Color.black.opacity(0.2))
                                    .ignoresSafeArea()
                                VStack {
                                    Text("AI 졸업사진")
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                    Text("갤러리에 있는 사진으로 빠르게 졸업사진 만들기")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                }
                                .foregroundStyle(Color.white)
                                .padding(.bottom, 100)
                                .vBottom()
                            }
                            VStack {
                                HStack {
                                    Text("AI 이미지 생성 횟수가")
                                    Text("\(remainingCountStore.remainingCount)")
                                        .fontWeight(.bold)
                                        .foregroundColor(remainingCountStore.remainingCount > 0 ? Color.purple : Color.red)
                                    Text("번 남았습니다.")
                                }
                                ZStack {
                                    GrayButtonComponent()
                                        .background(Color("NeutralColor_600")
                                        .cornerRadius(10))

                                    HStack {
                                        Button(action: {
                                            checkAgree.toggle()
                                        }) {
                                            HStack {
                                                Image(systemName: checkAgree ? "checkmark.square.fill" : "square")
                                                    .foregroundColor(checkAgree ? Color.blue : Color.gray)

                                                Text("개인정보 수집에 동의합니다.")
                                                    .foregroundStyle(Color.white)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        .padding(.leading, 16)

                                        Spacer()

                                        NavigationLink(destination: PrivacyPolicyView()) {
                                            Text("자세히")
                                                .foregroundColor(.white)
                                                .underline()
                                        }
                                        .padding(.trailing, 16)
                                    }
                                }
                                .frame(width: CGFloat.screenWidth * 0.9, height: 50)

                                NavigationLink {
                                    SelectUniv()
                                        .onAppear {
                                            isShowingTabBar = false
                                        }
                                        .onDisappear {
                                            isShowingTabBar = true
                                        }
                                } label: {
                                    ZStack {
                                        if (remainingCountStore.remainingCount != 0) && checkAgree && arePermissionsGranted { // 권한 확인 추가
                                            ButtonComponent()
                                        } else {
                                            GrayButtonComponent()
                                        }
                                        Text("사진 생성하기")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle((remainingCountStore.remainingCount == 0 || !checkAgree || !arePermissionsGranted) ? LinearGradientStyle.grayGradient : LinearGradientStyle.blackGradient) // 권한 확인 추가
                                            .contentShape(Rectangle())
                                    }
                                }
                                .buttonStyle(PressedButtonStyle())
                                .frame(width: CGFloat.screenWidth * 0.9)
                                .disabled(remainingCountStore.remainingCount <= 0 || !checkAgree || !arePermissionsGranted) // 권한 확인 추가
                            }
                            .vBottom()
                            .padding(.bottom)
                        } // VStack
                    }
                } // else

                if checkPermissions {
                    PermissionCheckerView(checkCameraPermission: true, checkPhotoLibraryPermission: true)
                        .frame(width: 0, height: 0) // 보이지 않게 설정
                        .onAppear {
                            checkPermissionsIfNeeded()
                        }
                }
            }
            .padding(.bottom)
            .background(Color.clear)
        }
        .onReceive(willEnterForeground) { _ in
            DispatchQueue.main.async {
                self.checkPermissions = true
            }
        }
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                retryFetchRemainingChance()
                DispatchQueue.main.async {
                    checkAgree = false
                }
            }
        }
        .onAppear {
            checkPermissions = true
        }
    }

    private func checkPermissionsIfNeeded() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = scene.windows.first?.rootViewController {
            let checkerView = PermissionCheckerView(checkCameraPermission: true, checkPhotoLibraryPermission: true)
            checkerView.checkPermissions(from: viewController) { cameraGranted, photoLibraryGranted in
                // 카메라와 앨범 권한이 모두 허용되었을 때 변수 설정
                if cameraGranted && photoLibraryGranted {
                    DispatchQueue.main.async {
                        arePermissionsGranted = true
                    }
                }
            }
        } else {
            print("Failed to retrieve the root view controller.")
        }
    }

    func retryFetchRemainingChance() {
        fetchRemainingChance { success in
            if !success && retryCount < maxRetryCount {
                retryCount += 1
                DispatchQueue.global().asyncAfter(deadline: .now() + retryDelay) {
                    retryFetchRemainingChance()
                }
            } else {
                isLoading = false
            }
        }
    }

    func fetchRemainingChance(completion: @escaping (Bool) -> Void) {
        let url = "http://3.39.13.136:3000/user/remaining-count"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        print("Fetching remaining chance...")
        print("URL: \(url)")
        print("Headers: \(headers)")

        AF.request(url, headers: headers).responseDecodable(of: RemainingCountResponse.self) { response in
            switch response.result {
            case .success(let value):
                DispatchQueue.main.async {
                    print("Successfully fetched remaining chance: \(value.remainingCount)")
                    self.remainingCountStore.remainingCount = value.remainingCount
                    self.retryCount = 0
                    completion(true)
                }
            case .failure(let error):
                print("Error fetching remaining chance: \(error)")
                if let data = response.data {
                    print("Server response: \(String(data: data, encoding: .utf8) ?? "No response body")")
                }
                completion(false)
            }
        }
    }
}

struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(isShowingTabBar: .constant(true))
            .environmentObject(RemainingCountStore())
    }
}


