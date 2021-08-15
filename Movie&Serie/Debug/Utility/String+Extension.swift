//
//  String+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 09/08/21.
//

import Foundation
import UIKit

extension String {
    func buildReleaseDate() -> String {
        var auxString = self.replacingOccurrences(of: "-", with: "")
        let year = auxString.prefix(4)
        let removeYear = auxString.startIndex..<auxString.index(auxString.startIndex, offsetBy: 4)
        auxString.removeSubrange(removeYear)
        let month = auxString.prefix(2)
        let removeMonth = auxString.startIndex..<auxString.index(auxString.startIndex, offsetBy: 2)
        auxString.removeSubrange(removeMonth)
        let day = auxString.prefix(2)

        return String("Lançamento: " + day + "/" + month + "/" + year)
    }
}
