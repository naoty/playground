//
//  ResultContainerViewController.swift
//  ResultContainer
//
//  Created by Naoto Kaneko on 3/10/16.
//  Copyright © 2016 Naoto Kaneko. All rights reserved.
//

import UIKit

class ResultContainerViewController: UIViewController {
    private var successViewController = UIStoryboard(name: "PokemonTableView", bundle: nil).instantiateInitialViewController() as? PokemonTableViewController
    private var failureViewController = UIStoryboard(name: "EmptyView", bundle: nil).instantiateInitialViewController() as? EmptyViewController
    
    var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController(activeViewController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeViewController = successViewController
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        guard let inactiveViewController = inactiveViewController else {
            return
        }
        
        inactiveViewController.willMoveToParentViewController(nil)
        inactiveViewController.view.removeFromSuperview()
        inactiveViewController.removeFromParentViewController()
    }
    
    private func updateActiveViewController(activeViewController: UIViewController?) {
        guard let activeViewController = activeViewController else {
            return
        }
        
        addChildViewController(activeViewController)
        activeViewController.view.frame = view.bounds
        view.addSubview(activeViewController.view)
        activeViewController.didMoveToParentViewController(self)
    }
}

extension ResultContainerViewController: ResultContainerViewControllerType {
    func transitionToSuccessContent() {
        activeViewController = successViewController
    }
    
    func transitionToFailureContent() {
        activeViewController = failureViewController
    }
}
