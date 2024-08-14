//
//  EditVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI
import AVFoundation
import Photos

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


struct EditView: View {
    @State private var isPressed = false
    @State private var checkPermissions = false
    
    let willEnterForeground = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
          .makeConnectable()
          .autoconnect()
    var body: some View {
        NavigationStack{
            ZStack{
                GeometryReader { geometry in
                    VStack(spacing: 0){
                        TopView()
                            .frame(height: geometry.size.height * 480 / 852)
                            .ignoresSafeArea()
                        VStack{
                            Text("AI 이미지 생성 횟수가 N번 남았습니다.")
                                .font(.system(size: 15))
                            NavigationLink(
                                destination: SelectImageView(),
                                label: {
                                    ZStack {
                                        ButtonComponent()
                                            .onTapGesture {
                                                self.checkPermissions = true
                                            }
                                        Text("사진 생성하기")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            )
                            .buttonStyle(PressedButtonStyle())
                            .frame(width: CGFloat.screenWidth * 0.9)
                        }
                        .vBottom()
                    } // VStack
                }
                if checkPermissions {
                    PermissionCheckerView(checkCameraPermission: true, checkPhotoLibraryPermission: true)
                }
            }.padding(.bottom)
        }.onReceive(willEnterForeground) { _ in
            // 앱이 foreground로 돌아올 때 권한 상태를 다시 확인합니다.
            self.checkPermissions = true
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
        EditView()
    }
}
