//
//  UIViewControllerExtension.swift
//  iBOCA
//
//  Created by Dat Huynh on 9/23/19.
//  Copyright © 2019 sunspot. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
