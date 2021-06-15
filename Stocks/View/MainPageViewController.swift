
import UIKit

class MainPageViewController: UIViewController {
	
	var presenter: IMainPagePresenter
	
	init(presenter: IMainPagePresenter) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		let screenView = MainPageView()
		self.view = screenView
		
		self.presenter.didLoad(view: screenView)

		self.navigationItem.titleView = presenter.searchBar()

		self.bind()
	}
	
	func bind() {
		
		self.presenter.table()?.delegate = self
		self.presenter.table()?.dataSource = self
		
		self.presenter.searchBar()?.delegate = self
		
		presenter.didFoundError = {[weak self] alert in
			self?.present(alert, animated: true, completion: nil)
		}
	}
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numbersOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return presenter.cell(tableView, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		return presenter.configuration(tableView, for: indexPath)
    }
    
}

extension MainPageViewController: UISearchBarDelegate {

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		presenter.textDidChange(for: searchBar.text?.lowercased())
	}
	

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		presenter.searchBarSearchButtonClicked()
	}

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		presenter.searchBarCancelButtonClicked()
    }
}
