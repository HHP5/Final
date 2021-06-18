
import UIKit

final class LoginScreenAssembly {
	func build() -> UIViewController {
		let router = LoginScreenRouter()
		let userStorage = UserStorage()
		let presenter = LoginScreenPresenter(userStorage: userStorage, router: router)
		let controller = LoginScreenViewController(presenter: presenter)
		router.controller = controller
		return controller
	}
}
