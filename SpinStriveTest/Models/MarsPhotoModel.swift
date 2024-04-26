import Foundation

struct MarsPtoho: Identifiable, Codable {
    let id: Int
    let camera: Camera
    let image: String
    let earthDate: String
    let rover: Rover
    
    private enum CodingKeys: String, CodingKey {
        case id
        case camera
        case image = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    static func mock() -> MarsPtoho {
        MarsPtoho(
            id: 102685,
            camera: Camera.mock(),
            image: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG",
            earthDate: "2015-06-03",
            rover: Rover.mock()
        )
    }
}
