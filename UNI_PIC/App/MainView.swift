//
//  MainView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .Edit
    @State private var isShowingTabBar: Bool = true // TabBar 가시성 제어 변수 추가

    init() {
        UITabBar.appearance().isHidden = false
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        EditView(isShowingTabBar: $isShowingTabBar)
                            .tag(Tab.Edit)
                        ShareView()
                            .tag(Tab.Share)
                        MyAlbumView()
                            .tag(Tab.Album)
                    }
                }
                VStack {
                    Spacer()
                    if isShowingTabBar {
                        CustomTabBar(selectedTab: $selectedTab)
                            .background().padding(.bottom)
                    }
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

