import SwiftUI

struct SelectUniv: View {
    @State private var searchText: String = ""
    @State var selectedUniversity: String = ""
    
    let universities = [
        "연세대학교",
        "서울대학교",
        "고려대학교",
        "경희대학교",
        "중앙대학교",
        "이화여자대학교"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("학교 선택하기")
                    .fontWeight(.bold)
                    .hCenter()
                    .padding(.top, 20)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("학교명 검색하기", text: $searchText)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("NeutralColor_100"))
                .cornerRadius(8)
                .frame(height: 40)
                .disabled(true)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(universities.filter { searchText.isEmpty ? true : $0.contains(searchText) }, id: \.self) { university in
                        Text(university)
                            .foregroundStyle(university == "연세대학교" ? (selectedUniversity == university ? Color("selected") : .primary) : .gray)
                            .onTapGesture {
                                if university == "연세대학교" {
                                    selectedUniversity = university
                                }
                            }
                            .disabled(university != "연세대학교")
                        
                        if university != universities.last {
                            Divider()
                        }
                    }
                }
                .font(.body)
                .padding(.leading)
                
                Spacer()
                
                NavigationLink {
                    SelectImageView()
                } label: {
                    ZStack {
                        if !selectedUniversity.isEmpty {
                            ButtonComponent()
                        } else {
                            GrayButtonComponent()
                        }
                        Text("다음으로")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(!selectedUniversity.isEmpty ? LinearGradientStyle.blackGradient : LinearGradientStyle.grayGradient)
                    }
                }
                .disabled(selectedUniversity.isEmpty)
            }
            .padding([.leading, .trailing, .top])
        }
    }
}

struct SelectUniv_Previews: PreviewProvider {
    static var previews: some View {
        SelectUniv()
    }
}
