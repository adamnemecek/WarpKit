//
//  TimeSeries.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation

public protocol TimeSeriesCollection: BidirectionalCollection {
    associatedtype Timestamp: Comparable

    ///
    /// Note tha tthis is a closed range because 
    /// self[timestamp...timestamp] == self[timestamp] == SubSequence
    ///
    subscript (in timerange: ClosedRange<Timestamp>) -> SubSequence { get }

    func replaceTimerange<C : Collection>(_ timerange: Range<Timestamp>, with newElements: C) where C.Iterator.Element == Iterator.Element

}

extension TimeSeriesCollection {
    public subscript(at timestamp: Timestamp) -> SubSequence {
        return self[in: timestamp...timestamp]
    }
}

