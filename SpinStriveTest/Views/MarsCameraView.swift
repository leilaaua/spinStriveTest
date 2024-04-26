import SwiftUI

struct MarsCameraView<T : MarksCameraViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                CustomNavBarView(
                    pickerType: $viewModel.pickerType,
                    selectedDate: $viewModel.selectedDate
                )
                
                if viewModel.isLoading {
                    Loader()
                } else if
                    viewModel.isEmptyViewShown {
                    MarsEmptyView()
                } else {
                    scrollStackView
                }
            }
            
            .overlay(
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(viewModel.pickerType != nil ? 0.4 : 0)
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

#Preview {
    MarsCameraView(viewModel: MarksCameraViewModel(networkLayer: NetworkLayer()))
}
