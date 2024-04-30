import SwiftUI

extension HistoryCellView {
    var roverTextView: some View {
        Text(TextConstants.roverDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        
        +
        Text(filterEntity.rover?.capitalized ?? "")
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var dateTextView: some View {
        Text(TextConstants.dateDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        +
        
        Text(filterEntity.date?.convertToString() ?? "")
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var cameraTextView: some View {
        Text(TextConstants.cameraDescription)
            .font(.body)
            .foregroundColor(.layerTwo)
        +
        
        Text(CameraEnum(rawValue: filterEntity.camera ?? "")?.displayName ?? "")
            .font(.body)
            .bold()
            .foregroundColor(.layerOne)
    }
}
