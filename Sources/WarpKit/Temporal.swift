//
//  Temporal.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation

public protocol TimestampType: Strideable, ExpressibleByIntegerLiteral {}

public protocol Temporal: Comparable, Strideable {
  associatedtype Timestamp: TimestampType
  var timestamp: Timestamp { get }
}

extension BidirectionalCollection where Iterator.Element: Temporal {
    public var timedomain: ClosedRange<Iterator.Element.Timestamp>? {
        return first.map { $0.timestamp...self.last!.timestamp }
    }
}
