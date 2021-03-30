
import UIKit

class MainPageViewController: UIViewController{
    
    private var tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchBar = UISearchBar()
    private let segment = UISegmentedControl(items: ["",""])
    private var viewModel = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setActivityIndicator()
        
        setSearchBarSetting()
        
        setSegmentView()
        segment.selectedSegmentIndex = 0
        
        viewModel.fetchCompanyProfile { [weak self] (error) in
            
            DispatchQueue.main.async { [weak self] in
                
                guard error == nil else{
                    
                    let alert = AlertService.alert(message: error!.localizedDescription)
                    self?.present(alert, animated: true)
                    
                    return
                }
                
                self?.setTableView()
                self?.tableView.reloadData()
                self?.stopActivityIndicator()
                
            }
        }
    }
    
    func setActivityIndicator() {
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        startActivityIndicator()
    }
    
    private func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func setSegmentView(){
        view.addSubview(segment)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segment.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segment.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        segment.setTitle("STOCKS", forSegmentAt: 0)
        segment.setTitle("FAVORITES", forSegmentAt: 1)
        
        
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: segment.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier )
        tableView.rowHeight = 100
    }
    
    func setSearchBarSetting(){
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier, for: indexPath) as? StockCell
        guard let stockCell = cell else { return UITableViewCell() }
        let cellViewModel = viewModel.stockCellViewModel(forIndexPath: indexPath)
        stockCell.cellModel = cellViewModel
        return stockCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "Favorite") { [self] (action, view, handler) in
//            viewModel.deleteNote(at: indexPath.row)
            viewModel.favoriteButtonPressed(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        likeAction.image = UIImage(systemName: "heart.fill")
        likeAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [likeAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}

extension MainPageViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text?.lowercased() {
            
            if searchText == "" {
                viewModel.searchBarCancelButtonClicked()
                self.searchBar.endEditing(true)
                
            } else{
                
                viewModel.searchBarSearchButtonClicked(for: searchText)
                
            }
            tableView.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        self.searchBar.endEditing(true)
        
        viewModel.searchBarCancelButtonClicked()
        
        tableView.reloadData()
    }
}
