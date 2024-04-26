import SwiftUI
import SDWebImageSwiftUI

extension PhotoFullScreenView {
    var closeButtonView: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(IconConstants.lightCloseIcon)
                .resizable()
                .frame(width: 44, height: 44)
                .padding()
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                dragOffset = gesture.translation
            }
            .onEnded { gesture in
                dragOffset = .zero
                position.width += gesture.translation.width
                position.height += gesture.translation.height
            }
    }
    
    func process(new magnitude: CGFloat, updating scale: inout CGFloat) {
        let magnification = lastScale + magnitude - 1.0
        if magnification >= minZoom && magnification <= maxZoom {
            scale = magnification
        } else if magnification < minZoom {
            scale = minZoom
        } else if magnification > maxZoom {
            scale = maxZoom
        }
    }
    
    var magnificationGesture: some Gesture {
        MagnificationGesture(minimumScaleDelta: 0.0)
            .onChanged { gesture in
                process(new: gesture.magnitude, updating: &scale)
            }
            .onEnded { gesture in
                process(new: gesture.magnitude, updating: &lastScale)
                scale = lastScale
            }
    }
    
    var imageView: some View {
        WebImage(url: URL(string: image.replacingOccurrences(of: "http://", with: "https://")))
            .resizable()
            .indicator(.activity)
            .frame(height: UIScreen.main.bounds.width)
            .scaleEffect(scale)
            .offset(x: xOffset, y: yOffset)
            .animation(.easeInOut(duration: 0.2), value: scale)
            .animation(.linear(duration: 0.2), value: dragOffset)
            .animation(.linear(duration: 0.2), value: position)
    }
}

