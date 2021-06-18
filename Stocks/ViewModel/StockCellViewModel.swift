
import UIKit

class StockCellViewModel: StockCellViewModelType {
    
    private var profile: CompanyProfile
    
    init(profile: CompanyProfile) {
        self.profile = profile
        
    }
    
    var stockTicker: String {
        return profile.symbol
    }
    
    var companyName: String {
        return profile.companyName
    }
    
    var lastPrice: String {
        let price = "\(profile.latestPrice) $"
        return price
    }
    
    var priceChange: String {
        let percent = String(format: "%.2f", profile.changePercent * 100)
        let change = "\(profile.change)$ (\(percent)%)"
        return change
    }
    
	var textColor: UIColor {
		return priceChange.contains("-") ? .red : .systemGreen
	}
    
    var imageURL: URL {

        let emptyPicture = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png")
        guard let imageURL = profile.imageURL?.url else { return emptyPicture! }
        return imageURL
    }
    
}
