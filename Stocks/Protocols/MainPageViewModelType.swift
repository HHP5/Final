
import Foundation

protocol MainPageViewModelType {
    
    var numbersOfRow: Int {get}
    
    func fetchCompanyProfile(completion: @escaping(NetworkError?)->())
    
    func stockCellViewModel(forIndexPath indexPath: IndexPath)-> StockCellViewModelType?
    
    func searchBarSearchButtonClicked(for searchText: String)
    
    func searchBarCancelButtonClicked()
    
    func favoriteButtonPressed(at index: Int)
}
