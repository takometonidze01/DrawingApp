//
//  AppCoordinator.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Private properties
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Internal properties
    
   
    
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    
    }
    
    func start() {
        
        let vc = GalleryViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func paintVC() {
        
        let vc = PaintViewController.instantiateFromStoryboard()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Your picture saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] action in
            // go to main vc
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.navigationController?.present(alert, animated: true)
    }
}

