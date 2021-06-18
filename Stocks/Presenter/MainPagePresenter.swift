
import UIKit

protocol IMainPagePresenter {
	var numbersOfRow: Int {get}
	var didFoundError: ((UIAlertController) -> Void)? {get set}
	func didLoad(view: IMainPageView)
	func table() -> UITableView?
	func searchBar() -> UISearchBar?
	func cell(_ tableView: UITableView, for indexPath: IndexPath)  -> TableCell
	func configuration(_ tableView: UITableView, for indexPath: IndexPath) -> UISwipeActionsConfiguration?
	func textDidChange(for searchText: String?)
	func searchBarSearchButtonClicked()
	func searchBarCancelButtonClicked()
}

class MainPagePresenter: IMainPagePresenter {
	var numbersOfRow: Int {
		return viewModel.numbersOfRow
	}
	
	var didFoundError: ((UIAlertController) -> Void)?
	
	private var viewModel: MainPageViewModelType
	
	private weak var screenView: IMainPageView?
	
	init(viewModel: MainPageViewModelType) {
		self.viewModel = viewModel
		
		self.fetch()
	}
	
	func fetch() {
		viewModel.fetchCompanyProfile { [weak self] (error) in
			
			DispatchQueue.main.async { [weak self] in
				
				guard error == nil else{
					
					let alert = AlertService.alert(message: error!.localizedDescription)
					self?.didFoundError?(alert)
					return
				}
				
				self?.screenView?.setTableView()
				self?.screenView?.tableView.reloadData()
				self?.screenView?.stopActivityIndicator()
				
			}
		}
	}
	
	func didLoad(view: IMainPageView) {
		self.screenView = view
	}
	
	func table() -> UITableView? {
		return screenView?.tableView
	}
	
	func searchBar() -> UISearchBar? {
		return screenView?.searchBar
	}
	
	func cell(_ tableView: UITableView, for indexPath: IndexPath)  -> TableCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
		let cellViewModel = viewModel.stockCellViewModel(forIndexPath: indexPath)
		cell.cellModel = cellViewModel
		return cell
	}
	
	func configuration(_ tableView: UITableView, for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let likeAction = UIContextualAction(style: .normal, title: "Favorite") { [self] (action, view, handler) in
			viewModel.favoriteButtonPressed(at: indexPath.row)
			DispatchQueue.main.async {
				self.screenView?.tableView.reloadData()
			}
		}

		likeAction.image = UIImage(systemName: "heart.fill")
		likeAction.backgroundColor = .red

		let configuration = UISwipeActionsConfiguration(actions: [likeAction])
		configuration.performsFirstActionWithFullSwipe = false
		return configuration
	}
	
	func textDidChange(for searchText: String?) {
		guard let searchText = searchText else { return }
		
		if searchText == "" {
			viewModel.searchBarCancelButtonClicked()
			self.screenView?.searchBar.endEditing(true)
			
		} else {
			viewModel.searchBarSearchButtonClicked(for: searchText)
		}
		screenView?.tableView.reloadData()
	}
	
	func searchBarSearchButtonClicked() {
		screenView?.searchBar.endEditing(true)
	}

	func searchBarCancelButtonClicked() {
		
		screenView?.searchBar.text = nil
		screenView?.searchBar.endEditing(true)

        viewModel.searchBarCancelButtonClicked()

		screenView?.tableView.reloadData()
	}

	
}
