//
//  GameItem.swift
//  SudokuGame
//
//  Created by top on 2020/8/25.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameItem: UIControl {
        
    private let titleLabel = UILabel()
    
    /// 是否选中数字
    var isSelectedNumber = false { didSet{ updateTheme()} }
    
    /// 是否为空白 item
    var isBlankItem = false { didSet{ updateTheme()} }
    
    /// 源数据
    var sourceNumber: Int = 0 { didSet{ updateTheme() } }
    
    /// 显示的数字
    var displayNumber: Int = 0 { didSet{ updateTheme() } }
    
    /// 是否为提示
    var isPrompt = false { didSet{ updateTheme() } }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.blue.cgColor
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
        if isPrompt {
            isEnabled = false
            layer.borderWidth = 0
            titleLabel.text = "\(sourceNumber)"
            backgroundColor = isBlankItem ? UIColor(white: 0, alpha: 0.1) : .white
        } else {
            isEnabled = isBlankItem
            layer.borderWidth = isSelected ? 2 : 0
            titleLabel.text =  displayNumber == 0 ? "" : "\(displayNumber)"
            
            if isSelectedNumber, displayNumber > 0 {
                backgroundColor = .orange
            } else {
                backgroundColor = isBlankItem ? UIColor(white: 0, alpha: 0.1) : .white
            }
        }
    }
}
