
import UIKit

protocol ILoginScreenRouter: AnyObject {
	func openMainScreen(user: UserModel)
}

final class LoginScreenRouter: ILoginScreenRouter {
	
	weak var controller: UIViewController?
	
	func openMainScreen(user: UserModel) {
		guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
		
		let viewController = MainScreenRouter(user: user)
		window.rootViewController = viewController.returnController()
		window.makeKeyAndVisible()
		window.overrideUserInterfaceStyle = .light
	}
	
}
