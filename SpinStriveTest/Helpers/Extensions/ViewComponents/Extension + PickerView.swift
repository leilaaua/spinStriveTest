import SwiftUI

extension PickerView {
    @ViewBuilder
    func pickerView() -> some View {
        switch viewModel.pickerType {
        case .camera:
            Picker("", selection: $viewModel.selectedCamera) {
                
                ForEach(CameraEnum.cameras(for: viewModel.selectedRover), id: \.self) { item in
                    Text("\(item.displayName)")
                        .foregroundColor(.layerOne)
                        .font(.system(size: 22))
                        .bold()
                        .tag(item.displayName)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            
        case .rover:
            Picker("", selection: $viewModel.temporarySelectedRover) {
                ForEach(RoverEnum.allCases.map { $0 }, id: \.self) { item in
                    Text("\(item.rawValue.capitalized)")
                        .foregroundColor(.layerOne)
                        .font(.system(size: 22))
                        .bold()
                        .tag(item.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
        default: EmptyView()
        }
    }
}

