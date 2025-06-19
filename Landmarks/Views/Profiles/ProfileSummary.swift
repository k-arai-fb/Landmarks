import SwiftUI


struct ProfileSummary: View {
    @Environment(ModelData.self) var modelData
    var profile: Profile
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                
                
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
                
                
                Divider()
                
                
                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)
                    
                    
                    ScrollView(.horizontal) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                            // 色相回転
                                .hueRotation(Angle(degrees: 90))
                            HikeBadge(name: "Tenth Hike")
                            // グレースケールの効果（0〜1）
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }
                
                
                Divider()
                
                
                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)
                    
                    
                    HikeView(hike: modelData.hikes[0])
                }
            }
        }
    }
}


#Preview {
    // Profile 型に定義された static let default プロパティ
    ProfileSummary(profile: Profile.default)
        .environment(ModelData())
}
