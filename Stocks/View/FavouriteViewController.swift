

import UIKit

class FavouriteViewController: UIViewController {
	var presenter: IFavouritePresenter
	
	init(presenter: IFavouritePresenter) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.fetch()
	}

	override func loadView() {
		super.loadView()
		
		let screenView = FavouritePageView()
		self.view = screenView
		
		self.presenter.didLoad(view: screenView)
		
		self.presenter.collection()?.delegate = self
		self.presenter.collection()?.dataSource = self
		
	}
}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.numbersOfRow ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return presenter.cell(collectionView, for: indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.width - 20, height: 100.0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let alert = presenter.didSelectItemAt(at: indexPath)
		self.present(alert, animated: true, completion: nil)

	}
	
	
	
}
