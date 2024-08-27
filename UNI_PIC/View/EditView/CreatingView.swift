import SwiftUI

struct CreatingView: View {
    @EnvironmentObject var cameraVM: CameraViewModel
    @State private var isBanner1 = true
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var navigateToResultSelectionView = false
    @State private var isTextColorChanged = false

    var body: some View {
        NavigationStack {
            VStack {
                Image(isBanner1 ? "createBanner" : "createBanner2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: CGFloat.screenWidth * 0.9, height: CGFloat.screenWidth * 0.9)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom)

                VStack(spacing: 20) {
                    Text("STEP 2")
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradientStyle.colorGradient)
                    Text("AI 사진 생성")
                }
                
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("어플을 종료하지 마세요 (종료시 기회가 날아갈 수 있습니다.)")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
                .padding(.top, 20)

                ProgressView()
                    .scaleEffect(1.2)
                    .vCenter()

                VStack(spacing: 10) {
                    Text("Generating...")
                        .multilineTextAlignment(.center)
                        .fontWeight(.heavy)
                        .font(.system(size: 25))
                    Text("사용자의 이미지를 분석하고 있습니다.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(isTextColorChanged ? .gray : .black) // 색상 변경
                    if isTextColorChanged {
                        Text("AI가 이미지를 처리하고 있습니다.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            .vTop()
            .onReceive(timer) { _ in
                isBanner1.toggle()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    isTextColorChanged = true
                }
            }
            .onChange(of: cameraVM.isImageUploadCompleted) { oldvalue, isCompleted in
                if isCompleted {
                    print("isImageUploadCompleted changed: \(isCompleted)")
                    navigateToResultSelectionView = true
                    print(cameraVM.uploadedImageURLs)
                }
            }
            .navigationDestination(isPresented: $navigateToResultSelectionView) {
                ResultSelectionView(isShowingTabBar: .constant(true), uploadedImageURLs: cameraVM.uploadedImageURLs)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CreatingView_Previews: PreviewProvider {
    static var previews: some View {
        CreatingView()
    }
}
