import Foundation

enum NetworkError: Error {
    case errorResponse
    case errorData
    case errorDecode(error: Error)
    case invalidURL
    case httpRequestFailed
}
