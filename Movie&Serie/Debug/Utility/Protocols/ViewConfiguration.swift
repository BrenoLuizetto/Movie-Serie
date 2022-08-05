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
    func setupViewConfiguration()
}

extension BuildViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        makeConstraints()
        configElements()
    }
    
    func configElements() {
        // Not Implemented
    }
}
