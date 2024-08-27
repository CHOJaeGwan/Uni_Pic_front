////
////  NewDrinkView.swift
////  UNI_PIC
////
////  Created by 조재관 on 4/15/24.
////
//
//import SwiftUI
//
//struct NewDrinkView: View {
//    // 음료 이미지
//    @State private var drinkImage: Image? = Image("note")
//    // 이미지선택창 선택 여부
//    @State private var presentsImagePicker = false
//    // 카메라 선택 여부
//    @State private var onCamera = false
//    // 사진 앨범 선택 여부
//    @State private var onPhotoLibrary = false
//    
//    var body: some View {
//        VStack {
//            // 음료이미지 선택 시 이미지선택창 띄우기
//            if let image = drinkImage {
//               image
//                   .resizable()
//                   .aspectRatio(contentMode: .fit)
//                   .onTapGesture { presentsImagePicker = true }
//           }
//        }
//        // 카메라 선택
//        .sheet(isPresented: $onCamera) {
//            ImagePicker(sourceType: .camera) { (pickedImage) in
//                drinkImage = Image(uiImage: pickedImage)
//            }
//        }
//        // 사진 앨범 선택
//        .sheet(isPresented: $onPhotoLibrary) {
//            ImagePicker(sourceType: .photoLibrary) { (pickedImage) in
//                drinkImage = Image(uiImage: pickedImage)
//            }
//        }
//        .actionSheet(isPresented: $presentsImagePicker) {
//            ActionSheet(
//                title: Text("이미지 선택하기"),
//                message: nil,
//                buttons: [
//                    .default(
//                        Text("카메라"),
//                        action: { onCamera = true }
//                    ),
//                    .default(
//                        Text("사진 앨범"),
//                        action: { onPhotoLibrary = true }
//                    ),
//                    .cancel(
//                        Text("돌아가기")
//                    )
//                ]
//            )
//        }
//    }
//}
//struct NewDrinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewDrinkView()
//    }
//}
