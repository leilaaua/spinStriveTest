import SwiftUI

struct MarsEmptyView: View {
    
    var body: some View {
        ZStack {
            Color.backgroundOne.edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 20) {
                        Image(IconConstants.emptyImage)
                            .resizable()
                            .frame(width: 145, height: 145)
                        Text(TextConstants.noData)
                            .font(.body)
                            .foregroundColor(.layerTwo)
                            .multilineTextAlignment(.center)
                    }
                        .frame(maxWidth: 193)
                )
        }
    }
}

#Preview {
    MarsEmptyView()
}
