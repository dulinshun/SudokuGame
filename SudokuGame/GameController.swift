//
//  GameController.swift
//  SudoKuManagerGame
//
//  Created by top on 2020/8/24.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    // 游戏等级
    var level: GameLevel = .low
    
    private let source = GameSource()

    private let gridView = GridView()
    
    private let scoreLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = level.title
        let item1 = UIBarButtonItem(title: "重置", style: .plain, target: self, action: #selector(reset))
        let item2 = UIBarButtonItem(title: "提示", style: .plain, target: self, action: #selector(chengPrompt))
        self.navigationItem.rightBarButtonItems = [item1, item2]
        
        self.view.backgroundColor = .white
        self.source.level = level
        
        // 表格
        let width = view.bounds.width - 40
        gridView.frame = CGRect(x: 20, y: 100, width: width , height: width)
        self.view.addSubview(gridView)
        gridView.successCallBack = { [weak self] () in
            self?.successful()
        }

        
        let inputView = GameInput()
        inputView.frame = CGRect(x: 20, y: gridView.frame.maxY + 50, width: view.bounds.width - 40, height: 100)
        inputView.layer.borderWidth = 1
        inputView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(inputView)
        inputView.inputNumber = { [weak self] (number) in
            self?.inputNumber(number)
        }
        inputView.clearNumber = { [weak self] () in
            self?.clearNumber()
        }
        
        // 初始数据
        self.reset()
    }
    
    deinit {
        print("释放", type(of: self))
    }
}

extension GameController {
    
    func inputNumber(_ number: Int) {
        gridView.input(number: number)
    }
    
    func clearNumber() {
        gridView.input(number: 0)
    }
    
    func successful() {
        let alertContoller = UIAlertController(title: "游戏胜利", message: "是否重新开始", preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "否", style: .cancel, handler: nil))
        alertContoller.addAction(UIAlertAction(title: "是", style: .default, handler: { [weak self] (_) in
            guard let `self` = self else { return }
            self.reset()
        }))
        self.present(alertContoller, animated: true, completion: nil)
    }
    
    @objc func chengPrompt() {
        gridView.isPrompt = !gridView.isPrompt
    }
    
    @objc func reset() {
        self.source.reset()
        gridView.set(sourceData: source.sourceData, displayData: source.displayData)
    }
}
