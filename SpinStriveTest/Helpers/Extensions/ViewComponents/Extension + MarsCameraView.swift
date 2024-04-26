import SwiftUI

extension MarsCameraView {
    var scrollStackView: some View {
        List {
            ForEach(viewModel.photos) { photo in
                RoverImageCellView(marsPhoto: photo)
                    .id(photo.id)
            }
            
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 20))
            
            if viewModel.hasNextPage {
                HStack {
                    Spacer()
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                    Spacer()
                }
                .padding(.vertical, 20)
                .listRowBackground(Color.clear)
                .onAppear {
                    Task {
                        await viewModel.loadMorePhotos(page: viewModel.page + 1)
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(Color.backgroundOne.edgesIgnoringSafeArea(.all))
    }
    
    @ViewBuilder
    func pickerView() -> some View {
        switch viewModel.pickerType {
        case .camera:
            PickerView(filterHeader: TextConstants.cameraHeader)
        case .rover:
            PickerView(filterHeader: TextConstants.roverHeader)
        case .calendar:
            DatePickerView()
        default:
            EmptyView()
        }
    }
}