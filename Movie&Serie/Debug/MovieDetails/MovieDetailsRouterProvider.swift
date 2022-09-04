//
//  RouterProvider.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/08/22.
//

import Foundation
import UIKit

protocol MovieDetailsRouterProvider {
    func goTo(route: String,
              from viewController: UIViewController,
              with parameters: [String: Any]?,
              completion: ((Bool) -> Void)?,
              callback: (([String: Any]) -> Void)?)
}
