import SwiftUI

struct SelectOptionView: View {
    @State var gender: String = ""
    @State var genderSelected: Bool = false
    @State var faceShape: String = ""
    @State var hairStyle: String = ""
    @EnvironmentObject var remainingCountStore: RemainingCountStore
    @EnvironmentObject var cameraVM: CameraViewModel
    @State private var navigateToCreatingView: Bool = false

    let genderName: [String] = ["boy", "girl"]
    let faceShapeName: [String] = ["oval.portrait", "rectangle.portrait", "shield"]
    let manHairStyles: [String] = ["close", "open"]
    let womanHairStyles: [String] = ["long", "short"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    VStack {
                        Text("선택 사항").bold()
                        Text("모델 이미지 학습 참고사항으로 전달됩니다.")
                    }
                    .padding(.bottom)

                    VStack {
                        Image("OptionBanner")
                            .resizable()
                            .scaledToFill()
                            .frame(width: CGFloat.screenWidth * 0.9, height: CGFloat.screenWidth * 0.8)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.bottom)

                        Text("성별 선택").bold().hLeading()
                        HStack {
                            ForEach(genderName, id: \.self) { genderOption in
                                Button(action: {
                                    self.gender = genderOption
                                    genderSelected = true
                                    hairStyle = ""
                                }) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(gender == genderOption ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient, lineWidth: 2.5)
                                        .frame(height: 40)
                                        .overlay {
                                            Text(genderOption == "boy" ? "남자" : "여자")
                                                .foregroundStyle(gender == genderOption ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient)
                                        }
                                }
                                .vTop()
                            }
                        }
                        .background()
                        .padding(.bottom)

                        Spacer()

                        VStack {
                            Text("얼굴형").bold().hLeading()
                            HStack {
                                ForEach(faceShapeName, id: \.self) { shapeOption in
                                    Button(action: {
                                        self.faceShape = shapeOption
                                    }) {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(faceShape == shapeOption ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient, lineWidth: 2.5)
                                            .frame(height: 40)
                                            .overlay {
                                                Image(systemName: shapeOption)
                                                    .foregroundStyle(faceShape == shapeOption ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient)
                                            }
                                    }
                                    .vTop()
                                }
                            }
                            .background()
                            .padding(.bottom)
                        }

                        Spacer()

                        if gender == "boy" || gender == "girl" {
                            VStack {
                                Text("헤어스타일").bold().hLeading()
                                HStack {
                                    let hairStyles = gender == "boy" ? manHairStyles : womanHairStyles
                                    ForEach(hairStyles, id: \.self) { style in
                                        Button(action: {
                                            self.hairStyle = style
                                        }) {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(hairStyle == style ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient, lineWidth: 2.5)
                                                .frame(height: 40)
                                                .overlay {
                                                    Text(hairStyleText(for: style))
                                                        .foregroundStyle(hairStyle == style ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient)
                                                }
                                        }
                                        .vTop()
                                    }
                                }
                                .background()
                                .padding(.bottom)
                            }
                        }
                    }
                    .background()
                    .padding(.top)

                    VStack {
                        Button(action: {
                            if genderSelected && !hairStyle.isEmpty && !faceShape.isEmpty && remainingCountStore.remainingCount > 0 {
                                Task {
                                    do {
                                        try await cameraVM.postImageData(
                                            gender: gender,
                                            faceShape: apiFaceShapeValue(for: faceShape),
                                            hairStyle: hairStyle
                                        )
                                        navigateToCreatingView = true
                                    } catch {
                                        print("API 요청 실패: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }) {
                            ZStack {
                                if genderSelected && !hairStyle.isEmpty && !faceShape.isEmpty && remainingCountStore.remainingCount > 0 {
                                    ButtonComponent()
                                } else {
                                    GrayButtonComponent()
                                }
                                Text("이미지 생성 횟수 1회 차감")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(genderSelected && !hairStyle.isEmpty && !faceShape.isEmpty && remainingCountStore.remainingCount > 0 ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient)
                            }
                        }
                        .disabled(!genderSelected || hairStyle.isEmpty || faceShape.isEmpty || remainingCountStore.remainingCount == 0)

                        HStack {
                            Text("AI 이미지 생성 횟수가")
                            Text("\(remainingCountStore.remainingCount)")
                                .fontWeight(.bold)
                                .foregroundColor(remainingCountStore.remainingCount > 0 ? Color.purple : Color.red)
                            Text("번 남았습니다.")
                        }
                        .font(.system(size: 15))
                    }
                    .vBottom()
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToCreatingView) {
                CreatingView()
                    .environmentObject(cameraVM)
            }
        }
    }

    private func hairStyleText(for style: String) -> String {
        if gender == "boy" {
            return style == "close" ? "덮은머리" : "내린머리"
        } else {
            return style == "long" ? "긴머리" : "단발"
        }
    }

    private func apiFaceShapeValue(for faceShape: String) -> String {
        switch faceShape {
        case "oval.portrait":
            return "round"
        case "rectangle.portrait":
            return "square"
        case "shield":
            return "slim"
        default:
            return ""
        }
    }
}

struct SelectOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectOptionView()
            .environmentObject(RemainingCountStore())
    }
}
