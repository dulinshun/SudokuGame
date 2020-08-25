//
//  GameItem.swift
//  SudokuGame
//
//  Created by top on 2020/8/25.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameItem: UIButton {

    var row: Int = 0
    var column: Int = 0
    var value: Int = 0 {
        didSet { updateTitle() }
    }
}

private extension GameItem {
    
    func updateTitle() {
        self.setTitle(value == 0 ? "" : "\(value)", for: .normal)
    }
}
