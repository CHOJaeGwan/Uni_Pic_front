//
//  SelectImageVIew.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/07.
//

import SwiftUI

struct SelectImageView: View {
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Text("내 사진 업로드 하기")
                }
                .padding(.bottom)
                VStack{
                    Text("좋은 사진 예시")
                    HStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                        Spacer()
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                        Spacer()
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                        
                    }
                    .padding(.bottom)
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5)
                        Text("얼굴이 선명하게 나온 셀카")
                            .hLeading()
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5)
                        Text("보정하지 않은 원본 사진")
                            .hLeading()
                    }
                }.padding(.bottom)
                Divider()
                VStack{
                    Text("나쁜 사진 예시")
                    HStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                        Spacer()
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                        Spacer()
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                    }.padding(.bottom)
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5)
                        Text("마스크/안경/선글라스/손 등으로 얼굴이 가려진 사진")
                            .hLeading()
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5)
                        Text("저화질/흔들린 사진")
                            .hLeading()
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5)
                        Text("얼굴이 너무 작게 나오거나 얼굴 전체가 나오지 않는 사진")
                            .hLeading()
                    }
                }
                NavigationLink{
                    SelectOptionView()
                } label: {
                    ZStack{
                        ButtonComponent()
                        Text("사진 업로드")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.black)
                    }
                }.vBottom()
            }.padding()
            .navigationTitle("STEP 1")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SelectImageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectImageView()
    }
}
