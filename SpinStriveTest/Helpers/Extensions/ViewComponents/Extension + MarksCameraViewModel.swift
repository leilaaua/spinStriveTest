import Foundation

//Requests
extension MarksCameraViewModel {
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
                hasNextPage = data.photos.count == perPage
                isLoading = false
                self.page += 1
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
                hasNextPage = data.photos.count == 25
                self.page += 1
            }
        } catch {
            print(NetworkError.errorResponse)
        }
    }
}
