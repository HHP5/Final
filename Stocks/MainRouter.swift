//
//  MainRouter.swift
//  Stocks
//
//  Created by Екатерина Григорьева on 15.06.2021.
//

import UIKit

internal final class MainRouter {
	
	private let tabbar: UITabBarController
	
	private let firstNavController: UINavigationController
	private let firstViewController: MainPageViewController

	
	private let secondNavController: UINavigationController
	private let secondViewController: FavouriteViewController
	
	internal init() {
		self.tabbar = UITabBarController()
		
		self.firstViewController = MainPageViewController(presenter: MainPagePresenter(viewModel: MainPageViewModel()))
		self.firstNavController = UINavigationController(rootViewController: self.firstViewController)
		
		self.secondViewController = FavouriteViewController(presenter: FavouritePresenter())
		self.secondNavController = UINavigationController(rootViewController: self.secondViewController)
		
		
		self.configFirstViewController()
		self.configSecondViewController()
		
		self.tabbar.setViewControllers([self.firstNavController,
										self.secondNavController],
									   animated: true)
		
	}
	
	internal func returnController() -> UITabBarController {
		return self.tabbar
	}
	
	private func configFirstViewController() {
		self.firstViewController.view.backgroundColor = .white
		
		self.firstNavController.tabBarItem.title = "STOCKS"
		self.firstNavController.tabBarItem.image = UIImage(systemName: "dollarsign.square")
		self.firstNavController.navigationBar.isHidden = false
	}
	
	private func configSecondViewController() {
		self.secondViewController.view.backgroundColor = .white
		
		self.secondNavController.tabBarItem.title = "FAVORITES"
		self.secondNavController.tabBarItem.image = UIImage(systemName: "heart.fill")
		self.secondNavController.navigationBar.isHidden = true
		
	}

	
}
