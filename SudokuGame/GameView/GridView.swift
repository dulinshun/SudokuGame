//
//  GridView.swift
//  SudokuGame
//
//  Created by top on 2020/8/25.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    /// 所有的 item
    private var items: [[GameItem]] = [] // 所有的item
    
    private let itemSpace: CGFloat = 1 // 间隔
    
    private let hSep1 = UIView() // 水平线 1
    
    private let hSep2 = UIView() // 水平线 2
    
    private let vSep1 = UIView() // 垂直线 1
    
    private let vSep2 = UIView() // 垂直线 2
    
    private var selectedItem: GameItem? //选中的item
    
    public var successCallBack: (() -> Void)? // 成功回调
    
    public var isPrompt = false { didSet{ updateIsPrompt() } }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        for _ in 0 ..< 9 {
            var aItems: [GameItem] = []
            for _ in 0 ..< 9 {
                let item = GameItem()
                item.addTarget(self, action: #selector(selectedItem(item:)), for: .touchUpInside)
                item.backgroundColor = .lightGray
                addSubview(item)
                aItems.append(item)
            }
            items.append(aItems)
        }
        
        hSep1.backgroundColor = UIColor.black
        addSubview(hSep1)
        
        hSep2.backgroundColor = UIColor.black
        addSubview(hSep2)
        
        vSep1.backgroundColor = UIColor.black
        addSubview(vSep1)
        
        vSep2.backgroundColor = UIColor.black
        addSubview(vSep2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = (bounds.width - 10 * itemSpace)/9
        
         for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                let item = items[i][j]
                let originX = itemSpace + (itemWidth + itemSpace) * CGFloat(i)
                let originY = itemSpace + (itemWidth + itemSpace) * CGFloat(j)
                item.frame = CGRect(x: originX, y: originY, width: itemWidth, height: itemWidth)
            }
        }
        
        /// 分割线
        hSep1.frame = CGRect(x: 0, y: (itemWidth + itemSpace) * 3, width: bounds.width, height: 1)
        hSep2.frame = CGRect(x: 0, y: (itemWidth + itemSpace) * 6, width: bounds.width, height: 1)
        vSep1.frame = CGRect(x: (itemWidth + itemSpace) * 3, y: 0, width: 1, height: bounds.width)
        vSep2.frame = CGRect(x: (itemWidth + itemSpace) * 6, y: 0, width: 1, height: bounds.width)
    }
}

private extension GridView {
    
    func updateItemsTheme() {
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                let item = items[i][j]
                item.isSelectedNumber = item.displayNumber == selectedItem?.displayNumber
            }
        }
    }
    
    @objc func selectedItem(item: GameItem) {
        if self.selectedItem == item { return }
        self.selectedItem?.isSelected = false
        item.isSelected = true
        self.selectedItem = item
        updateItemsTheme()
    }
    
    func items(column: Int) -> [GameItem] {
        var items: [GameItem] = []
        for i in 0 ..< 9 {
            items.append(self.items[i][column])
        }
        return items
    }
    
    func items(row: Int) -> [GameItem] {
        var items: [GameItem] = []
        for i in 0 ..< 9 {
            items.append(self.items[row][i])
        }
        return items
    }
    
    func items(box: Int) -> [GameItem] {
        var items: [GameItem] = []
        let mx = box/3*3
        let my = box%3*3
        for i in mx ..< mx + 3 {
            for j in my ..< my + 3{
                items.append(self.items[i][j])
            }
        }
        return items
    }
    
    func check(items: [GameItem]) -> Bool {
        let numbers = items.map{ $0.displayNumber }.sorted()
        return numbers.elementsEqual([1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
    
    func checkSucces() {
        for i in 0 ..< 9 {
            if !check(items: items(row: i)) { return }
            if !check(items: items(column: i)) { return }
            if !check(items: items(box: i)) { return }
        }
        self.successCallBack?()
    }
    
    func updateIsPrompt() {
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                let item = items[i][j]
                item.isPrompt = isPrompt
            }
        }
    }
}

extension GridView {

    /// 设置源数据
    func set(sourceData: [[Int]], displayData: [[Int]]) {
        self.selectedItem?.isSelected = false
        self.selectedItem = nil
        self.isPrompt = false
        updateItemsTheme()

        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                let item = items[i][j]
                item.sourceNumber = sourceData[i][j]
                item.displayNumber = displayData[i][j]
                item.isBlankItem = displayData[i][j] == 0
            }
        }
    }
    
    /// 输入数字
    func input(number: Int) {
        if let item = selectedItem, !isPrompt {
            item.displayNumber = number
            updateItemsTheme()
            checkSucces()
        }
    }
}
