//
//  CustomActionSheetView.swift
//  UNI_PIC
//
//  Created by 조재관 on 8/27/24.
//

import SwiftUI

struct CustomActionSheetView: View {
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var destructiveAction: () -> Void

    var body: some View {
        if isPresented {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("취소")
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        Button(action: {
                            destructiveAction()
                            isPresented = false
                        }) {
                            Text("탈퇴")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.bottom, 40)
                .padding(.horizontal,20)
            }
            .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
            .transition(.move(edge: .bottom))
        }
    }
}

