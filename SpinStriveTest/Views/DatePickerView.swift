import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var viewModel: MarksCameraViewModel
    
    var body: some View {
        VStack {
            PickerBarView(
                filterHeader: TextConstants.dateHeader,
                closeButtonAction: { viewModel.closePickerButton() },
                saveButtonAction: { viewModel.savePickerButton() }
            )
            
            DatePicker(
                "",
                selection: $viewModel.selectedDate,
                in: viewModel.dateClosedRange,
                displayedComponents: .date
            )
            .accentColor(.layerOne)
            .colorScheme(.light)
            .labelsHidden()
            .datePickerStyle(.wheel)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.backgroundOne)
                .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: -4)
        )
        .padding()
    }
}

#Preview {
    DatePickerView()
}
