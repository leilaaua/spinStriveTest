import SwiftUI

protocol MarksCameraViewModelProtocol: ObservableObject {
    var pickerType: PickerTypeEnum? { get set }
    var photos: [MarsPtoho] { get set }
    func getPhotos(page: Int) async
    var page: Int { get set }
    var isEmptyViewShown: Bool { get set }
    var selectedDate: Date { get set }
    var hasNextPage: Bool { get set }
    func loadMorePhotos(page: Int) async
    var isLoading: Bool { get set }
    var perPage: Int { get }
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
    
    let perPage = 25
    
    let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol) {
        self.networkLayer = networkLayer
        selectedDate = RoverEnum.date(for: selectedRover, isMax: false)
    }
    
    func getPhotos(page: Int) async {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            let data = try await networkLayer.fetchPhotosData(
                roverType: selectedRover.rawValue,
                cameraType: selectedCamera.rawValue,
                earthDate: selectedDate,
                page: page
            )
            await MainActor.run {
                photos = data.photos
                isEmptyViewShown = photos.isEmpty
                hasNextPage = photos.count == perPage
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                print(NetworkError.errorResponse)
            }
        }
    }
    
    func loadMorePhotos(page: Int) async {
        do {
            let data = try await networkLayer.fetchPhotosData(
                roverType: selectedRover.rawValue,
                cameraType: selectedCamera.rawValue,
                earthDate: selectedDate,
                page: page
            )
            await MainActor.run {
                isLoading = false
                photos.append(contentsOf: data.photos)
                hasNextPage = photos.count == 25
            }
        } catch {
            print(NetworkError.errorResponse)
        }
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
        default:
            pickerType = nil
            Task {
                await getPhotos(page: page)
            }
        }
    }
    
    func closePickerButton() {
        pickerType = nil
    }
}
