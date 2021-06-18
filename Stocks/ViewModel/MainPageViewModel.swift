
import Foundation

class MainPageViewModel: MainPageViewModelType {
        
    private var fullCompaniesList = [CompanyProfile]()
    private var companies = [CompanyProfile]()
	var favorite: FavouriteCompanyModel
	
	init(user: UserModel) {
		self.favorite = FavouriteCompanyModel(user: user)
	}

    func fetchCompanyProfile(completion: @escaping(NetworkError?)->()) {
        
        Tikers.symbols.forEach { (symbol) in
            
            ServiceLayer.request(router: Router.company(symbol: symbol)) { [weak self] (result: Result<CompanyProfile, NetworkError>) in
                
                switch result{
                
                case .failure(let error):
                    
                    completion(error)
                    
                case .success(var profile):
                    
                    
                    ServiceLayer.request(router: Router.logo(symbol: symbol)){ [weak self] (result: Result<Logo, NetworkError>) in
                    
                        switch result{
                        
                        case.failure(let error):
                            
                            completion(error)
                            
                        case .success(let url):
                            
                            profile.imageURL = url
                            self?.fullCompaniesList.append(profile)
                            self?.companies = self!.fullCompaniesList

                            if self?.fullCompaniesList.count == Tikers.symbols.count{
								completion(nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var numbersOfRow: Int{
        return companies.count
    }
    
    func stockCellViewModel(forIndexPath indexPath: IndexPath) -> StockCellViewModelType? {
        let profile = companies[indexPath.row]
        return StockCellViewModel(profile: profile)
    }
    
    
    func searchBarSearchButtonClicked(for searchText: String) {
        var arrayForPrinting = [CompanyProfile]()

        fullCompaniesList.forEach { (company) in

            let searchByName = company.companyName.lowercased().contains(searchText)
            let searchByTicker = company.symbol.lowercased().contains(searchText)

            if searchByName || searchByTicker{
                arrayForPrinting.append(company)
            }
			
            companies = arrayForPrinting

        }
    }

    func searchBarCancelButtonClicked() {
 
        companies = fullCompaniesList

    }
    
    func favoriteButtonPressed(at index: Int) {
		
		favorite.save(model: companies[index])
    }
    
}
