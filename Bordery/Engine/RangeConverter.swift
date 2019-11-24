//
//  RangeConverter.swift
//  Bordery
//
//  Created by Kevin Laminto on 11/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation

// struct class used to calcuate the new range whilst maintaing ratio
// from https://stackoverflow.com/questions/929103/convert-a-number-range-to-another-range-maintaining-ratio

struct RangeConverter {
    private let oldMax: Float
    private let oldMin: Float
    private let newMax: Float
    private let newMin: Float
    private let oldValue: Float
    
    private var newValue: Float
    
    init(oldMax: Float, oldMin: Float, newMax: Float, newMin: Float, oldValue: Float) {
        self.oldMax = oldMax
        self.oldMin = oldMin
        self.newMax = newMax
        self.newMin = newMin
        self.oldValue = oldValue
        
        self.newValue = 0
    }
    
    /**
     Creates a new value whilst maintaing the same ratio.
     */
    private mutating func calculateNewValue() {
        let oldRange = oldMax - oldMin
        let newRange = newMax - newMin
        let a = oldValue - oldMin
        let b = a * newRange
        let c = b / oldRange
        
        newValue = c + newMin
    }
    
    /**
     Creates a stringified version of the new value converted.
     - Parameter:
        - decimalPlace: the number of decimal place needed to be viewed
     - Returns: The value in string format.
     */
    mutating func getNewValueStr(decimalPlace: Int) -> String {
        let formatter = "%0.\(decimalPlace)f"
        
        calculateNewValue()
        return String(format: formatter, newValue)
    }
    
    /**
     Returns the new value in float data type.
     - Returns: the new value.
     */
    mutating func getNewValueFloat() -> Float {
        calculateNewValue()
        return newValue
    }
}
