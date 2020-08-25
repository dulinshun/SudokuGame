//
//  GameController.swift
//  SudoKuManagerGame
//
//  Created by top on 2020/8/24.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let array = SudoKuManager().displayArray
        
        for a in array {
            print(a)
        }
        
//        let itemWidth = 31
//        for i in 0 ..< 9 {
//            for j in 0 ..< 9 {
//                let item = GameItem()
//                item.row = i
//                item.column = j
//                item.value = array[i][j]
//                item.backgroundColor = .lightGray
//                item.frame = CGRect(x: 20 + j*(itemWidth+2), y: 64 + i*(itemWidth+2), width: itemWidth, height: itemWidth)
//                view.addSubview(item)
//            }
//        }
        
        let width = view.bounds.width - 40
        let gridView = GridView()
        gridView.frame = CGRect(x: 20, y: 100, width: width , height: width)
        gridView.addTarget(self, action: #selector(selecteItem(item:)))
        view.addSubview(gridView)
    }
}

extension GameController {
    
    @objc func selecteItem(item: GameItem) {
        
    }
}
