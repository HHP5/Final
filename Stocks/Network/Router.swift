
import Foundation

enum Router {
    
    case company(symbol: String)
    case logo(symbol: String)
    
    var scheme: String{
        switch self {
        case .company, .logo:
            return "https"
            
        }
    }
    
    var host: String {
        switch self {
        case  .company, .logo:
            return "cloud.iexapis.com"
        }
    }
    
    var path: String {
        switch self {
        
        case .company(let symbol):
            return "/stable/stock/\(symbol)/quote"
        case .logo(let symbol):
            return "/stable/stock/\(symbol)/logo/quote"
        }
    }
    
    var method: String {
        switch self {
        
        case .company, .logo:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        let token = "pk_eb7b1dc9f6774b0f8dca4839b336266c"
        
        switch self {
        
        case .company, .logo:
            return [URLQueryItem(name: "token", value: token)]
        }
    }
}
