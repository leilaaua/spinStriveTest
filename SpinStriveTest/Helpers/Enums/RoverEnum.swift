import Foundation

enum RoverEnum: String, CaseIterable, Hashable {
    case curiosity = "curiosity"
    case opportunity = "opportunity"
    case spirit = "spirit"
    
    static func date(for rover: RoverEnum, isMax: Bool = false) -> Date {
        switch rover {
        case .curiosity:
            return isMax ? "2024-02-19".convertToDate() : "2012-08-06".convertToDate()
        case .opportunity:
            return isMax ? "2018-06-11".convertToDate() : "2004-01-25".convertToDate()
        case .spirit:
            return isMax ? "2010-03-21".convertToDate() : "2004-01-04".convertToDate()
        }
    }
}
