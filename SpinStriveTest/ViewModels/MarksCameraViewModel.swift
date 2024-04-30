import SwiftUI
import Combine

protocol MarksCameraViewModelProtocol: ObservableObject {
    var pickerType: PickerTypeEnum? { get set }
    var photos: [MarsPtoho] { get set }
    func getPhotos(page: Int) async
    var page: Int { get set }
    var isEmptyViewShown: Bool { get set }
    var selectedDate: Date { get set }
    var selectedCamera: CameraEnum { get set }
    var selectedRover: RoverEnum { get set }
    var hasNextPage: Bool { get set }
    func addFiltersToDB()
    var coreDataService: CoreDataService { get }
    func loadMorePhotos(page: Int) async
    var isLoading: Bool { get set }
    var perPage: Int { get }
    var isShowingAlert: Bool { get set }
}

class MarksCameraViewModel: MarksCameraViewModelProtocol {
    @Published var pickerType: PickerTypeEnum?
    @Published var temporarySelectedRover: RoverEnum = .curiosity
    @Published var selectedRover: RoverEnum = .curiosity
    @Published var selectedCamera: CameraEnum = .all
    @Published var selectedDate: Date = Date()
    @Published var photos: [MarsPtoho] = []
    @Published var isEmptyViewShown: Bool = false
    @Published var hasNextPage: Bool = false
    @Published var page: Int = 1
    @Published var isLoading: Bool = true
    @Published var isShowingAlert: Bool = false
    
    let perPage = 25
    
    let networkLayer: NetworkLayerProtocol
    
    let coreDataService: CoreDataService
    
    var cancellables = Set<AnyCancellable>()
    
    init(networkLayer: NetworkLayerProtocol, coreDataService: CoreDataService) {
        self.networkLayer = networkLayer
        self.coreDataService = coreDataService
        selectedDate = RoverEnum.date(for: selectedRover, isMax: false)
        addSubscriber()
    }
    
    func addSubscriber() {
        coreDataService.$selectedFilter
            .sink { [weak self] returnedFilter in
                
                guard let self = self,
                      let camera = returnedFilter?.camera,
                      let cameraRaw = CameraEnum(rawValue: camera),
                      let rover = returnedFilter?.rover,
                      let roverRaw = RoverEnum(rawValue: rover),
                      let date = returnedFilter?.date
                else { return }
                
                selectedDate = date
                selectedRover = roverRaw
                temporarySelectedRover = roverRaw
                selectedCamera = cameraRaw
            }
            .store(in: &cancellables)
    }
    
    func addFiltersToDB() {
        coreDataService.addFilters(
            id: UUID(),
            rover: selectedRover.rawValue,
            camera: selectedCamera.rawValue,
            date: selectedDate
        )
    }
    
    var dateClosedRange: ClosedRange<Date> {
        let min = RoverEnum.date(for: selectedRover, isMax: false)
        let max =  RoverEnum.date(for: selectedRover, isMax: true)
        
        return min...max
    }
    
    func savePickerButton() {
        switch pickerType {
        case .rover:
            selectedRover = temporarySelectedRover
            
            selectedDate = RoverEnum.date(for: selectedRover, isMax: false)
            
            pickerType = nil
            
            Task {
                await getPhotos(page: page)
            }
            
            page = 1
        default:
            pickerType = nil
            Task {
                await getPhotos(page: page)
            }
            
            page = 1
        }
    }
    
    func closePickerButton() {
        pickerType = nil
    }
}
