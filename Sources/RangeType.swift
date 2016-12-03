//
//  RangeType.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation

public protocol RangeType {
    associatedtype Bound: Comparable
    var lowerBound: Bound { get }
    var upperBound: Bound { get }

    init(uncheckedBounds bounds: (lower: Bound, upper: Bound))

}

extension RangeType {
    public func clamp(_ value: Bound) -> Bound {
        return min(max(value, lowerBound), upperBound)
    }
}

extension Range: RangeType { }
extension CountableRange: RangeType { }
extension ClosedRange: RangeType { }
extension CountableClosedRange: RangeType { }

