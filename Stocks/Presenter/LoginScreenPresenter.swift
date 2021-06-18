

import Foundation

protocol ILoginScreenPresenter: ILoginScreenViewDelegate {
	var stocks: String {get}
	func viewDidLoad(uiView: ILoginScreenView)
}

final class LoginScreenPresenter: ILoginScreenPresenter {
	var stocks: String {
		var result = ""
		Tikers.symbols.forEach { symbol in
			result += " \(symbol) "
		}
		return result
	}
	
	private weak var uiView: ILoginScreenView?
	private let userStorage: IUserStorage
	private let router: ILoginScreenRouter

	init(userStorage: IUserStorage, router: ILoginScreenRouter) {
		self.userStorage = userStorage
		self.router = router
	}

	func viewDidLoad(uiView: ILoginScreenView) {
		self.uiView = uiView
		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
	}
	
}

extension LoginScreenPresenter: ILoginScreenViewDelegate {
	
	func login(login: String?, password: String?) {
		guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
			self.uiView?.showAlert(message: "Введите логин и пароль")
			return
		}
		guard let user = self.userStorage.getUser(login: login, password: password) else {
			self.uiView?.showAlert(message: "Пользователь не зарегистрирован или пароль не верен")
			return
		}
		self.router.openMainScreen(user: user)
	}

	func signin(login: String?, password: String?) {
		guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
			self.uiView?.showAlert(message: "Введите логин и пароль")
			return
		}
		guard self.userStorage.getUser(login: login, password: password) == nil else {
			self.uiView?.showAlert(message: "Такой пользователь уже зарегистрирован")
			return
		}
		self.uiView?.set(progress: true)
		let newUser = UserModel(login: login, password: password)
		self.userStorage.saveUser(user: newUser, completion: {
			self.uiView?.set(progress: false)
			self.router.openMainScreen(user: newUser)
		})
	}
}
