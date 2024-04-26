import SwiftUI

struct RoverImageCellView: View {
    @State var isImageFullScreenPresented: Bool = false
    @State var isDefaultImage: Bool = false
    
    let marsPhoto: MarsPtoho
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                roverTextView
                
                cameraTextView
                
                dateTextView
            }
            
            Spacer()
            
            imageView
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundOne)
                .shadow(color: .black.opacity(0.8), radius: 16, x: 0, y: 2)
        )
    }
}

#Preview {
    RoverImageCellView(marsPhoto: MarsPtoho.mock())
}
