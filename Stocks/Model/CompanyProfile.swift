
import Foundation


struct CompanyProfile: Codable {

    var companyName: String
    var symbol : String
    var latestPrice : Double
    var change : Double
    var changePercent: Double
    
    var imageURL: Logo?
}


struct Logo: Codable {
    var url: URL
}
