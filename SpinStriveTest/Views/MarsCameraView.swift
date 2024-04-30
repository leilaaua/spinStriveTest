import SwiftUI

struct MarsCameraView<T : MarksCameraViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    
                    CustomNavBarView(
                        pickerType: $viewModel.pickerType,
                        selectedDate: $viewModel.selectedDate,
                        addButtonAction: { viewModel.isShowingAlert = true }
                    )
                    
                    if viewModel.isLoading {
                        Loader()
                    } else if viewModel.isEmptyViewShown {
                        MarsEmptyView(message: TextConstants.noData)
                    } else {
                        scrollStackView
                    }
                }
                .alert(isPresented: $viewModel.isShowingAlert) {
                    alertContent
                }
                
                .overlay(
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                        .opacity(viewModel.pickerType != nil ? 0.4 : 0)
                )
                
                .overlay(
                    historyIcon, alignment: .bottomTrailing
                )
                
                .disabled(viewModel.pickerType != nil)
                
                pickerView()
            }
            .environmentObject(viewModel)
            .onAppear {
                Task {
                    await viewModel.getPhotos(page: viewModel.page)
                }
            }
        }
    }
}

#Preview {
    MarsCameraView(viewModel: MarksCameraViewModel(networkLayer: NetworkLayer(), coreDataService: CoreDataService()))
}
