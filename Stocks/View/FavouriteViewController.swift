//
//  FavouriteViewController.swift
//  Stocks
//
//  Created by Екатерина Григорьева on 15.06.2021.
//

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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = .red
	}

}
