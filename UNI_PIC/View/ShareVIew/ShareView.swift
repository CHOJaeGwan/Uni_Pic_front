//
//  ShareView.swift
//  UNI_PIC
//
//  Created by 조재관 on 2024/04/03.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        ZStack{
            Color("NeutralColor_200")
                .ignoresSafeArea()
            VStack{
                Text("UNIPIC")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                Text("아직 준비중인 기능입니다.")
                    .foregroundStyle(Color.white)
            }
            
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
