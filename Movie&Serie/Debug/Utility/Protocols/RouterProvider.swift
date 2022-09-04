//
//  RouterProvider.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/08/22.
//

import Foundation
import UIKit

class RouterProvider: MovieDetailsRouterProvider {
    
    func goTo(route: String,
              from viewController: UIViewController,
              with parameters: [String: Any]?,
              completion: ((Bool) -> Void)?,
              callback: (([String: Any]) -> Void)?) {
        
        switch route {
        case "alert":
            if let alert = parameters?["alert"] as? UIAlertController {
                viewController.present(alert,
                                       animated: true)
            }
            
        default: break
        }
    }
    
}
