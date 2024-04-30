import SwiftUI

extension HistoryView {
    var historyHeader: some View {
        Text(TextConstants.history)
            .foregroundColor(.layerOne)
            .font(.largeTitle)
            .bold()
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.accentOne.edgesIgnoringSafeArea(.top))
            .overlay(
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(IconConstants.leftIcon)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding()
                }
                ,
                alignment: .leading)
    }
    
    var alertContent: ActionSheet {
        ActionSheet(
            title: Text(TextConstants.menuFilter),
            buttons: [
                .default(Text(TextConstants.use), action: {
                    viewModel.coreDataService.selectedFilter = viewModel.selectedFilter
                    viewModel.isShowingAlert.toggle()
                }),
                .cancel(Text(TextConstants.cancel), action: {
                    viewModel.isShowingAlert.toggle()
                }),
                .destructive(Text(TextConstants.delete), action: {
                    guard let id = viewModel.selectedFilter?.id else { return }
                    
                    viewModel.coreDataService.deleteFilter(id: id)
                    viewModel.isShowingAlert.toggle()
                })
            ]
        )
    }
    
    var scrollViewContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(viewModel.savedFilters, id: \.self) { filter in
                    HistoryCellView(filterEntity: filter)
                        .onTapGesture {
                            viewModel.isShowingAlert.toggle()
                            viewModel.selectedFilter = filter
                        }
                }
            }
            .padding()
        }
        .padding(.all, 0)
    }
}

