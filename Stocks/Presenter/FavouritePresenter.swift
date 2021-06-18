
import UIKit

protocol IFavouritePresenter {
	var didFoundError: ((UIAlertController) -> Void)? {get set}
	var numbersOfRow: Int? {get set}
	func didLoad(view: IFavouritePageView)
	func fetch()
	func collection() -> UICollectionView?
	func cell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> FavouriteCollectionViewCell
	func didSelectItemAt(at indexPath: IndexPath) -> UIAlertController
}

class FavouritePresenter: IFavouritePresenter {
	
	private weak var screenView: IFavouritePageView?
	private var viewModel: IFavouritePageViewModel
	var didFoundError: ((UIAlertController) -> Void)?
	
	var numbersOfRow: Int?

	init(viewModel: IFavouritePageViewModel) {
		self.viewModel = viewModel
	}

	func fetch() {
		self.screenView?.startActivityIndicator()
		viewModel.getList  {
			self.bind()
		}
	}
	
	func bind() {
		self.numbersOfRow = self.viewModel.numbersOfRow
		self.screenView?.stopActivityIndicator()
		self.screenView?.collectionView?.reloadData()
	}
	
	func didLoad(view: IFavouritePageView) {
		self.screenView = view
	}
	
	func collection() -> UICollectionView? {
		return screenView?.collectionView
	}
	
	func cell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> FavouriteCollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCollectionViewCell.identifier, for: indexPath) as! FavouriteCollectionViewCell
		let cellViewModel = viewModel.stockCellViewModel(forIndexPath: indexPath)
		cell.cellModel = cellViewModel
		return cell
	}
	
	func didSelectItemAt(at indexPath: IndexPath) -> UIAlertController {
		let alert = UIAlertController(title: "Удалить из избранного?", message: nil, preferredStyle: .alert)
		let action = UIAlertAction(title: "Да", style: .default) { action in
			self.viewModel.deleteCompany(at: indexPath.row)
			self.fetch()
		}
		let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		alert.addAction(action)
		alert.addAction(cancel)
		
		return alert
	}
}
