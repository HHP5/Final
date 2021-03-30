
import UIKit
import Kingfisher

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
            changePriceLabel.textColor = cellModel.priceChange.contains("-") ? .red : .systemGreen
            
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changePriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyLogoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let isFavouriteImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(systemName: "heart")
        image.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews(){
        addSubview(stockTickerLabel)
        addSubview(companyNameLabel)
        addSubview(currentPriceLabel)
        addSubview(changePriceLabel)
        addSubview(companyLogoImage)
        addSubview(isFavouriteImage)
    }
    
    private func setConstraint(){
        companyLogoImage.topAnchor.constraint(equalTo: topAnchor,constant: 15).isActive = true
        companyLogoImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        companyLogoImage.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15).isActive = true
        companyLogoImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        stockTickerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stockTickerLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        stockTickerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105).isActive = true
        
        companyNameLabel.topAnchor.constraint(equalTo: stockTickerLabel.bottomAnchor).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: stockTickerLabel.leadingAnchor).isActive = true
        companyNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        companyNameLabel.widthAnchor.constraint(equalToConstant:150).isActive = true
        
        isFavouriteImage.leadingAnchor.constraint(equalTo: stockTickerLabel.trailingAnchor, constant: 5).isActive = true
        isFavouriteImage.topAnchor.constraint(equalTo: stockTickerLabel.topAnchor, constant: 5).isActive = true
        isFavouriteImage.heightAnchor.constraint(equalTo: stockTickerLabel.heightAnchor, constant: -10).isActive = true
        isFavouriteImage.widthAnchor.constraint(equalTo: stockTickerLabel.heightAnchor, constant: -10).isActive = true
        
        currentPriceLabel.topAnchor.constraint(equalTo: stockTickerLabel.topAnchor).isActive = true
        currentPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        currentPriceLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        changePriceLabel.topAnchor.constraint(equalTo: companyNameLabel.topAnchor).isActive = true
        changePriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        changePriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
