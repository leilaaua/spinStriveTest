import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    @Published var savedFilters: [FilterEntity] = []
    @Published var isShowingAlert: Bool = false
    @Published var selectedFilter: FilterEntity?
    
    var cancellables = Set<AnyCancellable>()
    
    let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        
        subscribe()
    }
    
    func subscribe() {
        coreDataService.$savedEntities
            .sink { [weak self] returnedFilters in
                self?.savedFilters = returnedFilters
            }
            .store(in: &cancellables)
    }
}
