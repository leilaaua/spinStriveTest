import SwiftUI

extension PickerBarView {
    var closeButton: some View {
        Button {
            closeButtonAction()
        } label: {
            Image(IconConstants.darkCloseIcon)
                .resizable()
                .frame(width: 44, height: 44)
        }
    }
    
    var filterHeaderView: some View {
        Text(filterHeader)
            .font(.system(size: 22))
            .bold()
            .foregroundColor(.layerOne)
    }
    
    var saveButtonView: some View {
        Button {
            saveButtonAction()
        } label: {
            Image(IconConstants.tickIcon)
                .resizable()
                .frame(width: 44, height: 44)
        }
    }
}

