import SwiftUI


struct CategoryItem: View {
    var landmark: Landmark
    
    
    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
            // 画像を「元のままの色」で表示
                .renderingMode(.original)
            // 元画像サイズにかかわらず、サイズ変更できるようにする
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}


#Preview {
    CategoryItem(landmark: ModelData().landmarks[0])
}
