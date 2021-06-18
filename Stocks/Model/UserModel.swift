

import Foundation

struct UserModel {
	
	let login: String
	let password: String

	init(login: String, password: String) {
		self.login = login
		self.password = password
	}

	init?(user: User) {
		guard let login = user.login,
			  let password = user.password
		else { return nil }
		self.login = login
		self.password = password
	}
}

