

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "collectionCell"
	
	private let cellView = StockCell()
	
	var cellModel: StockCellViewModelType?{
		willSet(cellModel) {
			guard let cellModel = cellModel else { return }
			
			cellView.setValues(for: cellModel)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure(){
		self.addSubview(cellView)
		cellView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.black.cgColor
		
		self.layer.cornerRadius = 20
		self.clipsToBounds = true
	}
}
