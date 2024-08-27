//
//  SelectImageView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/07.
//

import SwiftUI
import PhotosUI

struct SelectImageView: View {
    @StateObject private var cameraVM = CameraViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                    VStack {
                        VStack(spacing: 5) {
                            Text("Step 1")
                                .fontWeight(.bold)
                                .foregroundStyle(LinearGradientStyle.colorGradient)
                            Text("내 사진 업로드 하기")
                                .fontWeight(.bold)
                        }
                        .padding(.bottom)
                        
                        VStack {
                            Text("좋은 사진 예시")
                            HStack {
                                ForEach(0..<3) { index in
                                    if let image = UIImage(named: "NiceExample\(index + 1)") {
                                        Rectangle()
                                            .frame(width: CGFloat.screenWidth * 0.3, height: CGFloat.screenWidth * 0.3)
                                            .overlay(
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .scaledToFill()
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Rectangle()
                                            .frame(width: CGFloat.screenWidth * 0.3, height: CGFloat.screenWidth * 0.3)
                                            .foregroundColor(.gray)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay(Text("No Image"))
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                Text("얼굴이 선명하게 나온 셀카")
                                    .hLeading()
                            }
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                Text("보정하지 않은 원본 사진")
                                    .hLeading()
                            }
                        }
                        .padding(.bottom)
                        
                        Divider()
                        
                        VStack {
                            Text("나쁜 사진 예시")
                                .fontWeight(.bold)
                            HStack {
                                ForEach(0..<3) { index in
                                    if let image = UIImage(named: "BadExample\(index + 1)") {
                                        Rectangle()
                                            .frame(width: CGFloat.screenWidth * 0.30, height: CGFloat.screenWidth * 0.3)
                                            .overlay(
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .scaledToFill()
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Rectangle()
                                            .frame(width: CGFloat.screenWidth * 0.3, height: CGFloat.screenWidth * 0.3)
                                            .foregroundColor(.gray)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay(Text("No Image"))
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                Text("마스크/안경/선글라스/손 등으로 얼굴이 가려진 사진")
                                    .lineLimit(nil) // Allow text to wrap onto the next line
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(1)
                                    .hLeading()
                            }
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                Text("저화질/흔들린 사진")
                                    .lineLimit(nil) // Allow text to wrap onto the next line
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(1)
                                    .hLeading()
                            }
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                Text("얼굴이 너무 작게 나오거나 얼굴 전체가 나오지 않는 사진")
                                    .lineLimit(nil) // Allow text to wrap onto the next line
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(1)
                                    .hLeading()
                                
                            }
                        }
                        
                        if !cameraVM.selectedImages.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(cameraVM.selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }.padding(.bottom)
                        }
                        Spacer(minLength: 20)
                        Text("사진을 4장 이상 선택해주세요!(최대 6장)")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.red)
                        HStack {
                            ZStack {
                                PhotosPicker(selection: $cameraVM.imageSelections, matching: .images) {
                                    if !(cameraVM.selectedImages.count < 4 || cameraVM.selectedImages.count > 6) {
                                        GraySmallButtonComponent()
                                    } else {
                                        SmallColorButtonComponent()
                                    }
                                }
                                Text("사진 업로드")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle((cameraVM.selectedImages.count < 4 || cameraVM.selectedImages.count > 6) ? LinearGradientStyle.colorGradient : LinearGradientStyle.grayGradient)
                            }
                            
                            NavigationLink {
                                SelectOptionView()
                                    .environmentObject(cameraVM)
                            } label: {
                                ZStack {
                                    if (cameraVM.selectedImages.count < 4 || cameraVM.selectedImages.count > 6) {
                                        GraySmallButtonComponent()
                                    } else {
                                        SmallColorButtonComponent()
                                    }
                                    Text("다음으로")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .foregroundStyle((cameraVM.selectedImages.count < 4 || cameraVM.selectedImages.count > 6) ? LinearGradientStyle.grayGradient : LinearGradientStyle.colorGradient)
                                }
                            }
                            .disabled(cameraVM.selectedImages.count < 4 || cameraVM.selectedImages.count > 6)
                        }
                        .vBottom()
                    }
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct SelectImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectImageView()
            .environmentObject(RemainingCountStore())
    }
}
