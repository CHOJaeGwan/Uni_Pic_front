//
//  MainView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI

struct TabView: View {
    @State private var selectedTab: Tab = .Edit
    init(){
        UITabBar.appearance().isHidden = false
    }

    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $selectedTab){
                    EditView()
                        .tag(Tab.Edit)
                    ShareView()
                        .tag(Tab.Share)
                    MyAlbumView()
                        .tag(Tab.Album)
                }
            }
            VStack{
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
                    .background().padding(.bottom)
                    .background(Color.red)
            }.ignoresSafeArea(.all,edges: .bottom)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
