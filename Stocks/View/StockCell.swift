
import UIKit
import Kingfisher
import SnapKit

class StockCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    var cellModel: StockCellViewModelType?{
        willSet(cellModel) {
            guard let cellModel = cellModel else { return }
            
            companyLogoImage.kf.indicatorType = .activity
            
            stockTickerLabel.text = cellModel.stockTicker
            companyNameLabel.text = cellModel.companyName
            currentPriceLabel.text = cellModel.lastPrice
            
            changePriceLabel.text = cellModel.priceChange
            changePriceLabel.textColor = cellModel.textColor
            
            DispatchQueue.main.async { [self] in
                stockTickerLabel.invalidateIntrinsicContentSize()
                currentPriceLabel.invalidateIntrinsicContentSize()
                changePriceLabel.invalidateIntrinsicContentSize()
            }

            companyLogoImage.kf.setImage(with: cellModel.imageURL)
            isFavouriteImage.image = UIImage(systemName: cellModel.isFavoriteImage)
        }
    }
    
    
    private let stockTickerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .justified
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let changePriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private let companyLogoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        return image
    }()
    
    private let isFavouriteImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
		self.addSubview(companyLogoImage)
		companyLogoImage.snp.makeConstraints { make in
			make.top.leading.bottom.equalToSuperview().inset(15)
			make.width.equalTo(70)
		}
		
		self.addSubview(stockTickerLabel)
		stockTickerLabel.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.top.equalToSuperview().inset(15)
			make.leading.equalToSuperview().inset(105)
		}
		
		self.addSubview(companyNameLabel)
		companyNameLabel.snp.makeConstraints { make in
			make.top.equalTo(stockTickerLabel.snp.bottom)
			make.leading.equalTo(stockTickerLabel.snp.leading)
			make.height.equalTo(30)
			make.width.equalTo(150)
		}
		
		self.addSubview(isFavouriteImage)
		isFavouriteImage.snp.makeConstraints { make in
			make.leading.equalTo(stockTickerLabel.snp.trailing).offset(5)
			make.top.equalTo(stockTickerLabel.snp.top).inset(5)
			make.height.width.equalTo(stockTickerLabel.snp.height).inset(10)
		}
		
		self.addSubview(currentPriceLabel)
		currentPriceLabel.snp.makeConstraints { make in
			make.height.equalTo(35)
			make.top.equalTo(stockTickerLabel.snp.top)
			make.trailing.equalToSuperview().inset(20)
		}

		self.addSubview(changePriceLabel)
		changePriceLabel.snp.makeConstraints { make in
			make.height.equalTo(30)
			make.top.equalTo(companyNameLabel.snp.top)
			make.trailing.equalToSuperview().inset(20)
		}

    }
}
