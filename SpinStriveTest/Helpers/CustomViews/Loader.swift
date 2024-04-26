import SwiftUI

struct Loader: View {
    let circleCount = 4
    
    var body: some View {
        ZStack {
            Color.backgroundOne.edgesIgnoringSafeArea(.all)
                .overlay(
                    HStack(spacing: 15) {
                        ForEach(0..<circleCount, id: \.self) { item in
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 10, height: 10)
                                .modifier(BounceAnimation(delay: Double(item) * 0.25, duration: 0.6))
                        }
                    }
                )
        }
    }
}

#Preview {
    Loader()
}
