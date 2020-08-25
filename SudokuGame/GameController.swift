//
//  GameController.swift
//  SudoKuManagerGame
//
//  Created by top on 2020/8/24.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    let gridView = GridView()
    let manager = SudoKuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 表格
        let width = view.bounds.width - 40
        gridView.frame = CGRect(x: 20, y: 100, width: width , height: width)
        gridView.addTarget(self, action: #selector(selecteItem(item:)))
        view.addSubview(gridView)
        
        // 设置数据
        gridView.set(numbers: manager.displayArray)
    }
}

extension GameController {
    
    @objc func selecteItem(item: GameItem) {
        gridView.set(selected: item)
    }
}
