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
            EditVIew()
                .tabItem{
                    Image("editIcon")
                    Text("편집하기")
                        .foregroundColor(Color("NuetralColor/800"))
                }
            ShareView()
                .tabItem{
                    Image("shareIcon")
                    Text("공유하기")
                        .foregroundColor(Color("GradientColor/gradientColorS"))
                }
            MyAlbumView()
                .tabItem{
                    Image("albumIcon")
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
