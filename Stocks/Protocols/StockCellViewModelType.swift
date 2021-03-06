
import UIKit

protocol StockCellViewModelType {
    
    var stockTicker: String {get}
    
    var companyName: String {get}
        
    var lastPrice: String {get}
    
    var priceChange : String {get}
    
    var imageURL: URL {get}
    	
	var textColor: UIColor {get}
}
