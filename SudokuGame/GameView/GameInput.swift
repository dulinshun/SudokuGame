//
//  GameInput.swift
//  SudokuGame
//
//  Created by top on 2020/8/26.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit


class GameInput: UIView {

    private var buttons: [UIButton] = []
    
    private let clearButton = UIButton()
    
    var inputNumber: ((Int) -> Void)?
    
    var clearNumber: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        let texts = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        for text in texts {
            let button = UIButton();
            button.setTitle("\(text)", for: .normal);
            button.addTarget(self, action: #selector(selectedNumber(button:)), for: .touchUpInside);
            button.backgroundColor = .lightGray;
            button.tag = text
            addSubview(button)
            buttons.append(button)
        }
        
        clearButton.backgroundColor = .lightGray;
        clearButton.setTitle("清除", for: .normal)
        clearButton.addTarget(self, action: #selector(clearNumberAction), for: .touchUpInside)
        addSubview(clearButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = 40
        let leftX: CGFloat = 5
        let space: CGFloat = 10
        for i in 0 ..< buttons.count {
            let button = buttons[i]
            let originX = leftX + CGFloat(i%5) * (width + space)
            let originY = leftX + CGFloat(i/5) * (width + space)
            button.frame = CGRect(x: originX, y: originY, width: width, height: width)
        }
        
        clearButton.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        clearButton.center = CGPoint(x: bounds.width - 40, y: bounds.height/2)
    }
    
    @objc private func selectedNumber(button: UIButton) {
        self.inputNumber?(button.tag)
    }
    
    @objc private func clearNumberAction() {
        self.clearNumber?()
    }
}
