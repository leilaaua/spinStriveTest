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
                        await viewModel.loadMorePhotos(page: viewModel.page)
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
    
    var historyIcon: some View {
        NavigationLink(
            destination: HistoryView(coreDataService: viewModel.coreDataService)
        ) {
            Circle()
                .fill(Color.accentOne)
                .frame(width: 70, height: 70)
                .overlay(
                    Image(IconConstants.historyIcon)
                        .resizable()
                        .frame(width: 32, height: 32)
                )
                .padding()
        }
    }
    
    var alertContent: Alert {
        Alert(
            title: Text(TextConstants.saveFilters)
                .font(.system(size: 22, weight: .bold)),
            message: Text(TextConstants.saveFilterMessage),
            primaryButton: .default(Text(TextConstants.save), action: {
                viewModel.addFiltersToDB()
            }),
            secondaryButton: .cancel(Text(TextConstants.cancel), action: {
                viewModel.isShowingAlert = false
            })
        )
    }
}
