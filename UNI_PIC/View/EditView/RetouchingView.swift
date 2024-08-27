//
//  RetouchingView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/08.
//

import SwiftUI

struct RetouchingView: View {
    var selectedImageURL: String?

    var body: some View {
        VStack {
            if let imageURL = selectedImageURL {
                // 실제 이미지 URL을 사용하여 이미지를 로드하고 표시하는 방법을 구현합니다.
                // 예를 들어, URL을 통해 이미지를 로드하는 로직을 추가할 수 있습니다.
                Text("Selected Image URL: \(imageURL)")
                    .padding()
            } else {
                Text("이미지를 선택하지 않았습니다.")
                    .padding()
            }
        }
        .navigationTitle("Retouching View")
    }
}

struct RetouchingView_Previews: PreviewProvider {
    static var previews: some View {
        RetouchingView(selectedImageURL: "sampleURL")
    }
}
