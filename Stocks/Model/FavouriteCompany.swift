
import UIKit
import CoreData

class FavouriteCompanyModel {
	var companies: [Company] = []
	var context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
	var allCompanies: [CompanyProfile] = []
	var isLoad: (() -> Void)?
	private var user: UserModel
	
	init(user: UserModel) {
		self.user = user
		if allCompanies.isEmpty {
			self.fetchCompanyProfile { allCompanies in
				self.allCompanies = allCompanies
				self.isLoad?()
				
			}
		}
	}
	
	func getCompaniesList() -> [CompanyProfile] {
		self.loadCompanies()
		var list: [CompanyProfile] = []
		
		self.companies.forEach { company in
			allCompanies.forEach { comp in
				if comp.companyName == company.companyName {
					list.append(comp)
				}
			}
		}
		return list
	}
	
	func fetchCompanyProfile(comletion: @escaping([CompanyProfile]) -> Void ){
		
		Tikers.symbols.forEach { (symbol) in
			
			ServiceLayer.request(router: Router.company(symbol: symbol)) { [weak self] (result: Result<CompanyProfile, NetworkError>) in
				
				switch result{
				
				case .failure(let error):
					
					print(error)
					
				case .success(var profile):
					
					
					ServiceLayer.request(router: Router.logo(symbol: symbol)){ [weak self] (result: Result<Logo, NetworkError>) in
						
						switch result{
						
						case.failure(let error):
							
							print(error)
							
						case .success(let url):
							
							profile.imageURL = url
							self?.allCompanies.append(profile)

							if self?.allCompanies.count == Tikers.symbols.count{
								
								comletion(self!.allCompanies)
								
							}
						}
					}
				}
			}
		}
	}
	
	
	func deleteAllData() {
		
		let reqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
		let delAllReqVar = NSBatchDeleteRequest(fetchRequest: reqVar)
		do {
			try context.execute(delAllReqVar)
		} catch {
			print(error)
		}
	}
	
	func delete(company: CompanyProfile) {
		self.loadCompanies()
		self.companies.forEach { comp in
			if company.companyName == comp.companyName {
				deleteObject(comp)
			}
		}
	}
	
	func deleteObject(_ object: NSManagedObject) {
		context.delete(object)
		save()
	}
	
	func save(model: CompanyProfile) {
		self.loadCompanies()
		var inBase: Bool = false
		self.companies.forEach { company in
			if company.companyName == model.companyName {
				inBase = true
			}
		}
		if !inBase {
			let company = Company(context: self.context)
			company.change = model.change
			company.companyName = model.companyName
			company.changePercent = model.changePercent
			company.latestPrice = model.latestPrice
			company.symbol = model.symbol
			self.saveToUser(company)
			
			do {
				if let imageURL = model.imageURL {
					company.logo = try Data(contentsOf: imageURL.url)
				}
			}catch {
				company.logo = nil
			}
			self.companies.append(company)
			save()
		}
	}
	
	private func saveToUser(_ company: Company) {
		let request: NSFetchRequest<User> = User.fetchRequest()
		var users: [User] = []

		do {
			users = try context.fetch(request)
		} catch  {
			print("Error fetching data from context \(error)")
		}
		users.forEach { userr in
			if user.login == userr.login {
				company.user = userr
				save()
			}
		}
	}
	
	private func save() {
		do {
			try context.save()
		} catch {
			context.rollback()
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}
	
	private func loadCompanies() {
		let request: NSFetchRequest<Company> = Company.fetchRequest()
		
		let predicate = NSPredicate(format: "user.login MATCHES %@", user.login as! CVarArg)
		request.predicate = predicate
		
		do {
			companies = try context.fetch(request)
		} catch  {
			print("Error fetching data from context \(error)")
		}
	}
	
}
