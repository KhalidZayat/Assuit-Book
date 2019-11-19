
import Foundation

struct DapartmentsModel: Codable {
    let result: String
    let data: [Department]
}

struct Department: Codable {
    let id, name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
