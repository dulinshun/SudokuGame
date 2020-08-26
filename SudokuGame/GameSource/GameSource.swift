//
//  GameSource.swift
//  SudokuGame
//
//  Created by top on 2020/8/26.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

class GameSource {

    /// 游戏等级
    /// 1. 变更之后会重置数据
    var level: GameLevel = .low { didSet { reset() } }
    
    /// 源数据
    /// 1. 没有空格的数据
    /// 2. 重置之后会进行随机变更
    private(set) var sourceData: [[Int]] = []
      
    /// 显示的数据
    /// 1. 和源数据对应，但是部分数据以空格显示
    /// 2. 重置之后跟着源数据变更
    private(set) var displayData: [[Int]] = []
      
    
    init() {
        sourceData = [[1, 2, 3,  4, 5, 6,  7, 8, 9], [4, 5, 6,  7, 8, 9,  1, 2, 3], [7, 8, 9,  1, 2, 3,  4, 5, 6], [2, 1, 4,  3, 6, 5,  8, 9, 7], [3, 6, 5,  8, 9, 7,  2, 1, 4], [8, 9, 7,  2, 1, 4,  3, 6, 5], [5, 3, 1,  6, 4, 2,  9, 7, 8], [6, 4, 2,  9, 7, 8,  5, 3, 1], [9, 7, 8,  5, 3, 1,  6, 4, 2]]
        reset()
    }
}

extension GameSource {
    
    /// 重置
    func reset() {
        self.randomExchange()
        self.randomBlank()
    }
}


/// 私有操作
private extension GameSource {

    /// 交替性随机交换 行和列
    /// - Parameter frequency: 调整次数
    func randomExchange(frequency: Int = 20) {
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
            let tmp = sourceData[i][column1]
            sourceData[i][column1] = sourceData[i][column2]
            sourceData[i][column2] = tmp
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
            let tmp = sourceData[column1][i]
            sourceData[column1][i] = sourceData[column2][i]
            sourceData[column2][i] = tmp
        }
    }
    
    /// 随机挖空
    func randomBlank() {
        displayData.removeAll()
        displayData.append(contentsOf: sourceData)
        let blankCount = level.blankCount
        for i in 0 ..< 9 {
            let mx = i%3*3
            let my = i/3*3
            var count = 0
            let totalCount = blankCount + Int(arc4random()%2)
            while count < totalCount {
                let rx = mx + Int(arc4random()%3)
                let ry = my + Int(arc4random()%3)
                if displayData[rx][ry] != 0 {
                    displayData[rx][ry] = 0
                    count += 1
                }
            }
        }
    }
}
