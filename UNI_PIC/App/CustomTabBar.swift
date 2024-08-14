//
//  CustomTabBar.swift
//  UNI_PIC
//
//  Created by 조재관 on 4/11/24.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case Edit = "wand.and.stars"
    case Share = "square.and.arrow.up"
    case Album = "photo"
    
    var tabName: String {
        switch self {
        case .Edit:
            return "편집하기"
        case .Share:
            return "공유하기"
        case .Album:
            return "나의 앨범"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue){ tab in
                    Spacer()
                    VStack(spacing:10){
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundStyle(selectedTab == tab ?  LinearGradient(gradient: Gradient(colors: [Color("gradientColorS"), Color("gradientColorE")]), startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color("NuetralColor_200")], startPoint: .leading, endPoint: .trailing))
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)){
                                    selectedTab = tab
                                }
                            }
                        Text(tab.tabName)
                            .font(.system(size: 15))
                            .foregroundColor(Color("NuetralColor_800"))
                    }
                    Spacer()
                }
            }
        }
        .frame(width: CGFloat.screenWidth, height: 70)
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.Edit))
    }
}
