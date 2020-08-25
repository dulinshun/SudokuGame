//
//  GameItem.swift
//  SudokuGame
//
//  Created by top on 2020/8/25.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameItem: UIControl {

    private(set) var row: Int = 0 // 行索引
    
    private(set) var column: Int = 0 // 列索引
    
    private(set) var number: Int = 0 // 对应的值
    
    private(set) var isError = false // 是否错误显示
    
    private(set) var isSameSelectedNumber = false // 是否和选中的 item 有相同的数字
    
    private(set) var isBlankItem = false // 是否为空白 item
    
    let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
}

private extension GameItem {
    
    func updateTheme() {
        if isSelected {
            backgroundColor = .purple
        } else if isSameSelectedNumber {
            backgroundColor = .yellow
        }
    }
    
}

extension GameItem {

    func set(row: Int) {
        self.row = row
    }
    
    func set(column: Int) {
        self.column = column
    }
    
    func set(number: Int) {
        self.number = number
        self.titleLabel.text = number > 0 ? "\(number)" : ""
    }
    
    func set(selected: Bool) {
        self.isSelected = selected
        updateTheme()
    }
    
    func set(isError: Bool) {
        self.isError = isError
    }
    
    func set(isSameSelectedNumber: Bool) {
        self.isSameSelectedNumber = isSameSelectedNumber
        updateTheme()
    }
    
    func set(isBlankItem: Bool) {
        self.isBlankItem = isBlankItem
        updateTheme()
    }
}
