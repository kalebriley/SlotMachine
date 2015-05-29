//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by User on 5/29/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import Foundation

class SlotBrain {
    class func unpackSlotIntoRows(slots: [[Slot]]) -> [[Slot]]{
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }else if index == 1 {
                    slotRow2.append(slot)
                }else if index == 2 {
                    slotRow3.append(slot)
                }else{
                    println("error")
                }
            }
        }
        var slotsInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
        return slotsInRows
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int{
        var slotsInRows = unpackSlotIntoRows(slots)
        var winnings = 0
        
        var threeOfAKindWinCount = 0
        var flushWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            if checkFlush(slotRow) == true {
                println("flush")
                winnings += 1
                flushWinCount += 1
            }
            if flushWinCount == 3 {
                println("Royal Flush")
                winnings += 15
            }
            
            if checkThreeOfAKind(slotRow) {
                println("Three of a Kind")
                winnings += 3
                threeOfAKindWinCount += 1
            }
            if threeOfAKindWinCount == 3 {
                println("Threes all around")
                winnings += 50
            }
            
            if checkThreeInARow(slotRow) {
                println("three in a row")
                winnings += 1
                straightWinCount += 1
            }
            if straightWinCount == 3 {
                println("Epic straight")
                winnings += 1000
            }
        }
        
        
        return winnings
    }
    
    class func checkFlush(slots: [Slot]) -> Bool {
        var colorCount = 0
        
        for slot in slots{
            if slot.isRed {
                colorCount += 1
            }
        }
        if colorCount == 3 {
            return true
        }
        
        return false
    }
    
    class func checkThreeOfAKind(slots: [Slot]) -> Bool{
        if slots[0].value == slots[1].value && slots[1].value == slots[2].value {
            return true
        }
        
        return false
    }
    
    class func checkThreeInARow(slots: [Slot]) -> Bool{
        if slots[1].value - 1 == slots[0].value && slots[1].value + 1 == slots[2].value {
            return true
        }
        return false
    }
    
    
    
    
}
