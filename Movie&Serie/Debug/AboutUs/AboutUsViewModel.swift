//
//  AboutUsViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/02/22.
//

import Foundation
import UIKit

enum AboutUsCellType {
    case parent
    case child
}

enum AboutUsCellState {
    case collapsed
    case expanded
}

class AboutUsViewModel {
    var cellData: [aboutUsCellProtocol] = []
    
    init() {
        getCellData()
    }
    
    private func getCellData() {
        var cells = [aboutUsCellProtocol]()
        
        cells.append(getFirstCell())
        cells.append(getGitCell())
        cellData = cells
    }
    private func getFirstCell() -> aboutUsCellProtocol {
        var children: [aboutUsCellProtocol] = []
        children.append(AboutUsChildrenCellData(title: "Criado em 2021, com o objetivo de trazer informações sobre filmes e séries",
                                                type: .child,
                                                state: .collapsed,
                                                height: 70,
                                                children: []))
        return AboutUsParentCellData(title: "Sobre o aplicativo",
                                     type: .parent,
                                     state: .collapsed,
                                     height: 50,
                                     children: children)
    }
    
    private func getGitCell() -> aboutUsCellProtocol {
        var children: [aboutUsCellProtocol] = []
        children.append(AboutUsChildrenCellData(title: "Clique aqui para ser direcionado ao repositório",
                                                type: .child,
                                                state: .collapsed,
                                                height: 50,
                                                children: []))
        return AboutUsParentCellData(title: "GitHub",
                                     type: .parent,
                                     state: .collapsed,
                                     height: 50,
                                     children: children)
    }
    
    func collapse(indexPaths: [IndexPath], index: IndexPath) {
        cellData[index.row].state = .collapsed
        cellData[index.row].children = cellData[index.row].children.map { child -> AboutUsChildrenCellData in
            return AboutUsChildrenCellData(title: child.title,
                                           type: child.type,
                                           state: child.state,
                                           height: child.height,
                                           children: child.children)
        }

        for index in indexPaths {
            cellData.remove(at: index.row)
        }
    }
    
    func expanded(indexPaths: [IndexPath], index: IndexPath) {
        cellData[index.row].state = .expanded
        cellData[index.row].children = cellData[index.row].children.map { child -> AboutUsChildrenCellData in
            return AboutUsChildrenCellData(title: child.title,
                                           type: child.type,
                                           state: child.state,
                                           height: child.height,
                                           children: child.children)
        }
        
        for (cell, ind) in zip(cellData[index.row].children, indexPaths) {
            cellData.insert(cell, at: ind.row)
        }
    }
}

protocol aboutUsCellProtocol {
    var title: String { get }
    var type: AboutUsCellType { get }
    var state: AboutUsCellState { get set }
    var height: CGFloat { get }
    var children: [aboutUsCellProtocol] { get set }
}

class AboutUsParentCellData: aboutUsCellProtocol {
    var title: String
    var type: AboutUsCellType
    var state: AboutUsCellState
    var height: CGFloat
    var children: [aboutUsCellProtocol]
    
    init(title: String,
         type: AboutUsCellType,
         state: AboutUsCellState,
         height: CGFloat,
         children: [aboutUsCellProtocol]) {
        self.title = title
        self.type = type
        self.state = state
        self.height = height
        self.children =  children
    }
}

struct AboutUsChildrenCellData: aboutUsCellProtocol {
    var title: String
    
    var type: AboutUsCellType
    
    var state: AboutUsCellState
    
    var height: CGFloat
    
    var children: [aboutUsCellProtocol]
}
