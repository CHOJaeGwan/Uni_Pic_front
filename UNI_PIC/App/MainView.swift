//
//  MainView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            EditView()
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("편집하기")
                }
            ShareView()
                .tabItem{
                    Image(systemName: "square.and.arrow.up")
                    Text("공유하기")
                }
            MyAlbumView()
                .tabItem{
                    Image(systemName: "photo")
                    Text("나의 앨범")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
