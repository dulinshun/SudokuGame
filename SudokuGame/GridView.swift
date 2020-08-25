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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        for i in 0 ..< 9 {
            var aItems: [GameItem] = []
            for j in 0 ..< 9 {
                let item = GameItem()
                item.set(row: i)
                item.set(column: j)
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
                if let selectedItem = selectedItem {
                    item.set(selected: selectedItem == item)
                    item.set(isSameSelectedNumber: selectedItem.number == item.number)
                } else {
                    item.set(selected: false)
                    item.set(isSameSelectedNumber: false)
                    item.set(isError: false)
                }
            }
        }
    }
}

extension GridView {
    
    /// 添加方法
    func addTarget(_ target: Any?, action: Selector) {
        for items in items {
            for item in items {
                item.addTarget(target, action: action, for: .touchUpInside)
            }
        }
    }
    
    func set(selected item: GameItem?) {
        if self.selectedItem == item { return }
        self.selectedItem = item
        updateItemsTheme()
    }

    func set(numbers: [[Int]]) {
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                let item = items[i][j]
                let number = numbers[i][j]
                item.set(number: number)
            }
        }
    }
}
