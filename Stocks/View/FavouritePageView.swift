
import UIKit
import SnapKit

protocol IFavouritePageView: class {
	
	var collectionView: UICollectionView? {get set}
	func set()
	func stopActivityIndicator()
	func startActivityIndicator()
}

	
class FavouritePageView: UIView, IFavouritePageView {

	var collectionView: UICollectionView?
	
	private let activityIndicator = UIActivityIndicatorView(style: .large)

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.set()
		self.setActivityIndicator()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	 func set() {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
		layout.itemSize = CGSize(width: 60, height: 60)
		
		collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
		collectionView?.register(FavouriteCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteCollectionViewCell.identifier)
		
		self.addSubview(collectionView!)
		collectionView?.snp.makeConstraints{ make in
			make.edges.equalToSuperview()
		}
		self.collectionView?.isUserInteractionEnabled = true
		self.collectionView?.backgroundColor = .white
	
	}
	
	 func setActivityIndicator() {
		self.backgroundColor = .white
		self.addSubview(activityIndicator)
		
		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		startActivityIndicator()
	}
	
	 func startActivityIndicator() {
		collectionView?.isHidden = true
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {

		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
		
		collectionView?.isHidden = false

	}
	
}

