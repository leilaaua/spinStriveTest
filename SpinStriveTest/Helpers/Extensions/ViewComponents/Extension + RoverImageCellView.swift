import SwiftUI
import SDWebImageSwiftUI

extension RoverImageCellView {
    var roverTextView: some View {
        Text(TextConstants.roverDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        
        +
        Text(marsPhoto.rover.name)
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var dateTextView: some View {
        Text(TextConstants.dateDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        +
        
        Text(marsPhoto.earthDate)
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var cameraTextView: some View {
        Text(TextConstants.cameraDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        +
        
        Text(marsPhoto.camera.fullName)
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var imageView: some View {
        WebImage(url: URL(string: marsPhoto.image.replacingOccurrences(of: "http://", with: "https://")))
            .onFailure(perform: { _ in
                isDefaultImage = true
            })
            .resizable()
            .placeholder {
                Image(systemName: IconConstants.placeholderPhoto)
                    .resizable()
                    .frame(width: 130, height: 110)
                    .foregroundColor(.gray)
            }
            .indicator(.activity)
            .frame(width: 130, height: 130)
            .cornerRadius(20)
            .padding(.leading)
        
            .onTapGesture {
                if !isDefaultImage {
                    isImageFullScreenPresented = true
                }
            }
        
            .compatibleFullScreen(isPresented: $isImageFullScreenPresented) {
                PhotoFullScreenView(image: marsPhoto.image)
            }
    }
}

