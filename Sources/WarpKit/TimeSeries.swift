//
//  TimeSeries.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation

public protocol Sequenceable: BidirectionalCollection {
    associatedtype Timestamp: Comparable

    ///
    /// Note tha tthis is a closed range because 
    /// self[timestamp...timestamp] == self[timestamp] == SubSequence
    ///
    subscript (in timerange: ClosedRange<Timestamp>) -> SubSequence { get }

}

public extension Sequenceable {
//    public subscript(at timestamp: Timestamp) -> SubSequence {
//        return self[in: timestamp...timestamp]
//    }
}

public protocol RRTS: Sequenceable {
    func replaceTimerange<C : Collection>(_ timerange: ClosedRange<Timestamp>, with newElements: C) where C.Iterator.Element == Iterator.Element
}



//
// unlike a sorted array, the keys are sparse
// 
//

public struct TimeSeries<Event: Temporal>: MutableCollection,
                                           ExpressibleByArrayLiteral,
                                           DefaultConstructible,
                                           SequenceConstructible,
                                           Equatable {

  public typealias Timestamp = Event.Timestamp
  public typealias Index = Int
  public typealias SubSequence = ArraySlice<Event>

  fileprivate var content: SortedArray<Event> = []

  public init() {
    content = []
  }

  public init<S: Sequence>(_ seq: S) where S.Iterator.Element == Event {
    content = SortedArray(seq)
  }

  public init(arrayLiteral elements: Event...) {
    content = SortedArray(elements)
  }

  public var startIndex: Index {
    return content.startIndex
  }

  public var endIndex: Index {
    return content.endIndex
  }

  public func index(after index: Index) -> Index {
    return content.index(after: index)
  }

  public subscript (index: Index) -> Event {
    get {
      return content[index]
    }
    set {
        content[index] = newValue
    }
  }

  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return content[bounds]
    }
    set {
      content[bounds] = newValue
    }
  }

  public func indices(in timerange: ClosedRange<Timestamp>) -> ClosedRange<Index>? {
    let w: (Event) -> Bool = { timerange.contains($0.timestamp) }
    guard let f = (content.index(where: w))  else { return nil }
    guard let l = (content.lastIndex(where: w))  else { return nil }

    fatalError()
    return f...l
  }
}

extension TimeSeries: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    return content.index(before: index)
  }

  public func lastIndex(where: (Event) -> Bool) -> Index? {
    return content.lastIndex(where: `where`)
  }
}

extension TimeSeries: RangeReplaceableCollection {
  public mutating func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {

    content.replaceSubrange(subrange, with: newElements)
  }
}

//extension TimeSeries: TimeSeriesCollection {
//  public subscript(in timerange: ClosedRange<Timestamp>) -> SubSequence {
//    get {
//        let i = indices.filter { timerange.contains(self[$0].timestamp) }
//        guard let f = i.first else { return [] }
//        return self[f...i.last!]
//    }
////    set {
////    }
//  }
//}

//extension TimeSeries: RRTS {
//    public func replaceTimerange<C : Collection>(_ timerange: ClosedRange<Timestamp>, with newElements: C) where C.Iterator.Element == Event {
//        fatalError()
//
//    }
//
//}


public func ==<Event>(lhs: TimeSeries<Event>, rhs: TimeSeries<Event>) -> Bool {
  return lhs.content == rhs.content
}

