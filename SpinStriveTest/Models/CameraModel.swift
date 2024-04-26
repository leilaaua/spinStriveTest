import Foundation

struct Camera: Identifiable, Codable {
    let id: Int
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
    
    static func mock() -> Camera {
        Camera(id: 20, fullName:"Front Hazard Avoidance Camera")
    }
}
