import SwiftUI

struct PhotoFullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let image: String
    
    let minZoom: CGFloat = 1.0
    let maxZoom: CGFloat = 3.0
    
    @State var scale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    
    @State var dragOffset = CGSize.zero
    @State var position = CGSize.zero
    
    var xOffset: CGFloat {
        dragOffset.width + position.width
    }
    
    var yOffset: CGFloat {
        dragOffset.height + position.height
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
                .overlay(closeButtonView, alignment: .topLeading)
            
            imageView
                .gesture(
                    magnificationGesture
                        .simultaneously(with: dragGesture)
                )
            
                .onTapGesture(count: 2) {
                    scale = minZoom
                    position = .zero
                }
        }
    }
}

#Preview {
    PhotoFullScreenView(image: MarsPtoho.mock().image)
}
