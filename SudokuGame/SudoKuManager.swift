//
//  SudoKuManager.swift
//  SudoKuManagerGame
//
//  Created by top on 2020/8/25.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

extension SudoKuManager {
    enum Level {
        case low    // 低级
        case medium // 中级
        case higher // 高级
        
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
    }
}



public class SudoKuManager {
        
    /// 数独的源矩阵
    private(set) var array: [[Int]] = []
    
    /// 挖空之后的矩阵
    /// 用来显示的矩阵
    private(set) var displayArray: [[Int]] = []
    
    /// 等级
    private(set) var level = Level.low
    
    init() {
        /// 设置默认的数独。作为种子
        array = [[1, 2, 3,  4, 5, 6,  7, 8, 9], [4, 5, 6,  7, 8, 9,  1, 2, 3], [7, 8, 9,  1, 2, 3,  4, 5, 6], [2, 1, 4,  3, 6, 5,  8, 9, 7], [3, 6, 5,  8, 9, 7,  2, 1, 4], [8, 9, 7,  2, 1, 4,  3, 6, 5], [5, 3, 1,  6, 4, 2,  9, 7, 8], [6, 4, 2,  9, 7, 8,  5, 3, 1], [9, 7, 8,  5, 3, 1,  6, 4, 2]]
        
        /// 重置
        reset()
    }
}

public extension SudoKuManager {
    
    /// 重置数组
    func reset() {
        randomExchange(frequency: 20) // 随机交换
        makeBlank() // 挖空
    }
    
    
    /// 校验位于行列的数字
    /// - Parameters:
    ///   - row: 行数
    ///   - column: 列数
    ///   - value: 数字
    func check(row: Int, column: Int, value: Int) -> Bool {
        let result1 = checkRow(row: row, number: value)
        let result2 = checkColumn(column: column, number: value)
        let result3 = checkGrid(x: row, y: column, number: value)
        return result1 && result2 && result3
    }
}


/// 私有操作
private extension SudoKuManager {

    /// 随机调整
    /// - Parameter frequency: 调整次数
    /// 交替性随机交换 行和列
    func randomExchange(frequency: Int) {
        if frequency <= 0 { return }
        randomExchangeColumn(a: 0, b: 1, c: 2)  // 随机交换前三列
        randomExchangeRow(a: 0, b: 1, c: 2)     // 随机交换前三行
        
        randomExchangeColumn(a: 3, b: 4, c: 5)  // 随机交换中三列
        randomExchangeRow(a: 3, b: 4, c: 5)     // 随机交换中三行
        
        randomExchangeColumn(a: 6, b: 7, c: 8)  // 随机交换后三列
        randomExchangeRow(a: 6, b: 7, c: 8)     // 随机交换后三行
        
        randomExchange(frequency: frequency - 1)
    }
    
    /// 随机调整列
    /// - Parameters:
    ///   - a，b，c：列数
    ///   - frequency: 随机次数
    func randomExchangeColumn(a: Int, b: Int, c: Int) {
        guard a/3 == b/3, b/3 == c/3 else { return }
        var list = [a, b, c]
        let index = Int(arc4random()%UInt32(list.count))
        list.remove(at: index)
        let column1 = list[0]
        let column2 = list[1]
        for i in 0 ..< 9 {
            let tmp = array[i][column1]
            array[i][column1] = array[i][column2]
            array[i][column2] = tmp
        }
    }
    
    /// 随机调整行
    /// - Parameters:
    ///   - a，b，c：列数
    ///   - frequency: 随机次数
    func randomExchangeRow(a: Int, b: Int, c: Int) {
        guard a/3 == b/3, b/3 == c/3 else { return }
        var list = [a, b, c]
        let index = Int(arc4random()%UInt32(list.count))
        list.remove(at: index)
        let column1 = list[0]
        let column2 = list[1]
        for i in 0 ..< 9 {
            let tmp = array[column1][i]
            array[column1][i] = array[column2][i]
            array[column2][i] = tmp
        }
    }
    
    /// 挖空
    func makeBlank() {
        displayArray.removeAll()
        displayArray.append(contentsOf: array)
        let blankCount = level.blankCount
        for i in 0 ..< 9 {
            let mx = i%3*3
            let my = i/3*3
            var count = 0
            let totalCount = blankCount + Int(arc4random()%2)
            while count < totalCount {
                let rx = mx + Int(arc4random()%3)
                let ry = my + Int(arc4random()%3)
                if displayArray[rx][ry] != 0 {
                    displayArray[rx][ry] = 0
                    count += 1
                }
            }
        }
    }
    
    
    
    
    /// 校验行
    func checkRow(row: Int, number: Int) -> Bool {
        for i in 0 ..< 9 {
            if array[row][i] == number {
                return false
            }
        }
        return true
    }
    
    /// 校验列
    func checkColumn(column: Int, number: Int) -> Bool {
        for i in 0 ..< 9 {
            if array[i][column] == number {
                return false
            }
        }
        return true
    }
    
    /// 交易小九宫格
    func checkGrid(x: Int, y: Int, number: Int) -> Bool {
        let mx = x/3*3, my = y/3*3
        for i in mx ..< mx+3 {
            for j in my ..< my+3 {
                if array[i][j] == number {
                    return false
                }
            }
        }
        return true
    }
}
