//
//  Numeric.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation

public protocol DefaultConstructible {
    init()
}

protocol Addable {
    static func +(lhs: Self, rhs: Self) -> Self
}

protocol Numeric: Addable { }

extension Int: DefaultConstructible, Numeric { }
extension Double: DefaultConstructible, Numeric { }
extension Bool: DefaultConstructible { }

public protocol Movable: Comparable {
    associatedtype Delta
    func move(by delta: Delta) -> Self
}

extension Sequence where Iterator.Element: Movable {
    public func move(by delta: Iterator.Element.Delta) -> [Iterator.Element] {
        return map { $0.move(by: delta) }
    }
}

public func randomInt(bound: Int) -> Int {
    return Int(arc4random_uniform(UInt32(bound)))
}

public extension Int {
    public init(_ value: Bool) {
        self = value ? 1 : 0
    }
}
