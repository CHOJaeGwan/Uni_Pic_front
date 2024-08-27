//
//  AgreeView.swift
//  UNI_PIC
//
//  Created by 조재관 on 7/19/24.
//

import SwiftUI

struct AgreeView: View {
    var body: some View {
        VStack{
            Text("이용약관 및 개인정보 수집동의")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                
            ScrollView{
                Text("유니픽㈜(이하 회사)는 ｢개인정보 보호법｣ 제30조에 따라 이용자의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 및 공개합니다. 제1조 (개인정보의 처리목적) 회사는 다음의 목적을 위하여 개인정보를 처리하며, 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않습니다. 이용 목적이 변경되는 경우에는 ｢개인정보 보호법｣ 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다. 또한 회사는 만 14세 이상의 이용자를 대상으로 서비스를 제공하며, 14세 미만 아동의 개인정보가 수집된 사실을 인지하는 경우 해당 정보를 지체없이 삭제하겠습니다. 1. 회원 가입 및 관리 회원 가입의사 확인과 회원제 서비스 제공에 따른 회원자격 유지 및 관리, 서비스 부정이용 방지, 각종 고지와 통지, 고충처리 목적으로 개인정보를 처리합니다. 2. 재화 또는 서비스 제공 서비스 및 인앱구매, 콘텐츠, 광고를 포함한 맞춤형 서비스 제공을 목적으로 개인정보를 처리합니다. 3. 고충처리 이용자의 신원 확인, 문의사항 확인, 사실조사를 위한 연락, 통지, 처리결과 통보의 목적으로 개인정보를 처리합니다. 4. 이벤트 응모 이벤트 참여 기회 제공을 위해 개인정보를 처리합니다. 5. AI 촬영/편집 서비스 제공 AI 촬영/편집 서비스 제공을 목적으로 개인정보를 처리합니다. 제2조 (개인정보의 처리 및 보유기간) ① 회사는 법령에 명시되어 있거나 이용자로부터 개인정보 수집 시 동의 받은 개인정보의 보유 및 이용기간 내에서 개인정보를 처리 및 보유합니다.")
            }
            NavigationLink {
                SelectUniv()
            } label: {
                ZStack {
                    ButtonComponent()
                    Text("동의하고 계속하기")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(LinearGradientStyle.blackGradient)
                }
            }
            .buttonStyle(PressedButtonStyle())
            .frame(width: CGFloat.screenWidth * 0.9)
         }.padding()
    }
}

#Preview {
    AgreeView()
}
