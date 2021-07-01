//
//  CoordinatorProtocol.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//
import UIKit
protocol CoordinatorProtocol: AnyObject {

    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
    func paintVC()
    func showSuccessAlert()
}
