import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(coreDataService: CoreDataService) {
        _viewModel = ObservedObject(wrappedValue: HistoryViewModel(coreDataService: coreDataService))
    }
    
    var body: some View {
        ZStack {
            
            Color.backgroundOne
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                historyHeader
                
                if viewModel.coreDataService.savedEntities.isEmpty {
                    MarsEmptyView(message: TextConstants.noHistory)
                } else {
                    scrollViewContent
                }
            }
            .actionSheet(isPresented: $viewModel.isShowingAlert) {
                alertContent
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HistoryView(coreDataService: CoreDataService())
}
