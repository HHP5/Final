
import UIKit
import Kingfisher
import SnapKit

class TableCell: UITableViewCell {
    
    static let identifier = "Cell"
	
	private let cellView = StockCell()
    
    var cellModel: StockCellViewModelType?{
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
			cellView.setValues(for: cellModel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
		self.addSubview(cellView)
		cellView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
