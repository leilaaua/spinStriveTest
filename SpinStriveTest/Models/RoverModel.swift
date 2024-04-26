import Foundation

struct Rover: Identifiable, Codable {
    let id: Int
    let name: String
    let landingDate: String
    let maxDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case maxDate = "max_date"
    }
    
    static func mock() -> Rover {
        Rover(
            id: 5,
            name: "Curiosity",
            landingDate: "2012-08-06",
            maxDate: "2024-02-19"
        )
    }
}
