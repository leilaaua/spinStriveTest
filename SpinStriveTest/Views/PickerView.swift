import SwiftUI

struct PickerView: View {
    @EnvironmentObject var viewModel: MarksCameraViewModel
    
    let filterHeader: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.clear
            
            VStack {
                PickerBarView(
                    filterHeader: filterHeader,
                    closeButtonAction: { viewModel.closePickerButton() },
                    saveButtonAction: { viewModel.savePickerButton() }
                )
                .background(Color.clear)
                
                pickerView()
                
            }
            .padding()
            .frame(height: UIScreen.main.bounds.height * 0.3)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.backgroundOne)
                    .edgesIgnoringSafeArea(.bottom)
                    .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: -4)
            )
        }
    }
}

#Preview {
    PickerView(filterHeader: TextConstants.cameraHeader)
}
