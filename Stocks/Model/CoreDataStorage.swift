
import UIKit
import CoreData


protocol IUserStorage {
	func getUser(login: String, password: String) -> UserModel?
	func saveUser(user: UserModel, completion: @escaping () -> Void)
	func usersCount() -> Int
}

class UserStorage: IUserStorage {
	var context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer

	func getUser(login: String, password: String) -> UserModel? {
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.login)) = '\(login)' && \(#keyPath(User.password)) = '\(password)'")
		guard let object = try? self.context.viewContext.fetch(fetchRequest).first else { return nil }
		return UserModel(user: object)
	}

	func saveUser(user: UserModel, completion: @escaping () -> Void) {
		self.context.performBackgroundTask { context in
			let object = User(context: context)
			object.login = user.login
			object.password = user.password
			try? context.save()
			DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { completion() })
		}
	}

	func usersCount() -> Int {
		fatalError("Не реализовано")
	}
}
