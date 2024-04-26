import SwiftUI

struct PickerBarView: View {
    let filterHeader: String
    let closeButtonAction: () -> Void
    let saveButtonAction: () -> Void
    
    var body: some View {
        HStack {
            closeButton
            
            Spacer()
            
            filterHeaderView
            
            Spacer()
            
            saveButtonView
        }
        .background(Color.clear)
    }
}

#Preview {
    PickerBarView(
        filterHeader: TextConstants.cameraHeader,
        closeButtonAction: {},
        saveButtonAction: {}
    )
}
