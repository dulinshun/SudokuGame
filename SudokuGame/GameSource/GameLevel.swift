//
//  GameLevel.swift
//  SudokuGame
//
//  Created by top on 2020/8/26.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

enum GameLevel: Int {
    case low = 0    // 低级
    case medium = 1 // 中级
    case higher = 2 // 高级
}

extension GameLevel {
    
    /// 空格数量
    var blankCount: Int {
        switch self {
        case .low:
            return 2
        case .medium:
            return 4
        case .higher:
            return 6
        }
    }
    
    /// 标题
    var title: String {
        switch self {
        case .low:
            return "初级"
        case .medium:
            return "中级"
        case .higher:
            return "高级"
        }
    }
}
