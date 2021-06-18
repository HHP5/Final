//

import Foundation
import CoreData

protocol IFavouritePageViewModel {
	var numbersOfRow: Int? {get set}
	
	func getList(completion: @escaping (()->Void))
	
	func stockCellViewModel(forIndexPath indexPath: IndexPath)-> StockCellViewModelType?
	
	func deleteCompany(at index: Int)

}

class FavouritePageViewModel: IFavouritePageViewModel {
		
	private var companyList = [CompanyProfile]()
	private var user: UserModel
	var numbersOfRow: Int?

	init(user: UserModel) {
		self.user = user
	}
	
	func getList(completion: @escaping (()->Void)) {
		let model = FavouriteCompanyModel(user: user)

		model.isLoad = {
			self.companyList = model.getCompaniesList()
			self.numbersOfRow = self.companyList.count
			completion()
		}
	}
	
	func stockCellViewModel(forIndexPath indexPath: IndexPath) -> StockCellViewModelType? {
		if companyList.count > 0 {
			let profile = companyList[indexPath.row]
			return StockCellViewModel(profile: profile)
		} else {
			return nil
		}
	}
	
	func deleteCompany(at index: Int) {
		let model = FavouriteCompanyModel(user: user)
		let company = companyList[index]
		model.delete(company: company)
	}

	
}
