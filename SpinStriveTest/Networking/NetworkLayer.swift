import Foundation

protocol NetworkLayerProtocol {
    func fetchData(from url: URL) async throws -> Data
    
    func fetchPhotosData(
        roverType: String,
        cameraType: String,
        earthDate: Date,
        page: Int
    ) async throws -> Photos
}

final class NetworkLayer: NetworkLayerProtocol {
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            throw NetworkError.errorResponse
        }
        
        return data
    }
    
    func fetchPhotosData(roverType: String, cameraType: String, earthDate: Date, page: Int) async throws -> Photos {
        
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(roverType)/photos"
        let key = "n20cTt8Sq1QLFVBmp737EaucdKcJSfhghOjgWqGI"
        
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "earth_date", value: earthDate.convertToString()),
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if cameraType != "all" {
            urlComponents.queryItems?.append(URLQueryItem(name: "camera", value: cameraType))
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        print(url)
        
        do {
            let data = try await fetchData(from: url)
            
            do {
                return try JSONDecoder().decode(Photos.self, from: data)
            } catch let error {
                throw NetworkError.errorDecode(error: error)
            }
        } catch {
            throw NetworkError.httpRequestFailed
        }
    }
}
