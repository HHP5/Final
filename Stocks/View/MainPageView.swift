
import UIKit
import SnapKit

protocol IMainPageView: class {
	var tableView: UITableView {get set}
	var searchBar: UISearchBar {get set}
	func setTableView()
	func stopActivityIndicator()
}

class MainPageView: UIView, IMainPageView {
	
	var tableView = UITableView()
	var searchBar = UISearchBar()
	
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setActivityIndicator()
		self.setSearchBarSetting()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setTableView() {
		self.addSubview(tableView)
		
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier )
		tableView.rowHeight = 100
		
		tableView.allowsSelection = false
	}
	
	func stopActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
	
	private func setActivityIndicator() {
		self.backgroundColor = .white
		self.addSubview(activityIndicator)
		
		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		startActivityIndicator()
	}
	
	private func startActivityIndicator() {
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()
	}
	
	
	func setSearchBarSetting(){
		searchBar.searchBarStyle = .prominent
		searchBar.placeholder = " Search..."
		searchBar.sizeToFit()
		searchBar.isTranslucent = false
		searchBar.showsCancelButton = true
		searchBar.tintColor = .black
	}
	
}
