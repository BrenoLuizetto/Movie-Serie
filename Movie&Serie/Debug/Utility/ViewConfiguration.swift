//
//  ViewConfiguration.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import SnapKit

protocol BuildViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func makeConstraints()
    func configElements()
    func buildItems()
}

extension BuildViewConfiguration {
    func buildItems() {
        buildViewHierarchy()
        makeConstraints()
        configElements()
    }
}
