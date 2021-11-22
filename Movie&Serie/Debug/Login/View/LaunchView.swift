//
//  LaunchView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 23/09/21.
//

import Foundation
import UIKit
import SnapKit
import Gifu

class LaunchView: UIView {
    
    private lazy var gif: GIFImageView = {
        let imageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(gif)
        gif.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        showGif()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showGif() {
        guard let url = URL(string: "https://media.giphy.com/media/ycfHiJV6WZnQDFjSWH/giphy.gif?" +
                            "cid=ecf05e47wgkkdawhwjtjws7dapk76gukdy1occh1tghm1gd7&rid=giphy.gif&ct=g") else { return }
        gif.animate(withGIFURL: url)
    }
}
