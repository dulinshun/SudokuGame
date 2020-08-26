//
//  LevelController.swift
//  SudokuGame
//
//  Created by top on 2020/8/26.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class LevelController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择难度"
        self.view.backgroundColor = .white
        
        let levels = [GameLevel.low, GameLevel.medium, GameLevel.higher]
        for i in 0 ..< levels.count {
            let level = levels[i]
            let tag = level.rawValue
            let title = level.title
            
            let button = UIButton()
            button.tag = tag
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 5
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(selectedLevel(button:)), for: .touchUpInside)
            button.frame = CGRect(x: 60, y: 150 + 60 * CGFloat(i), width: view.bounds.width - 120, height: 40)
            view.addSubview(button)
        }
    }
    
    @objc func selectedLevel(button: UIButton) {
        let controller = GameController()
        controller.level = GameLevel(rawValue: button.tag)!
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
