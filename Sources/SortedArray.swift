//
//  SortedArray.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 10/1/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

public struct SortedArray<Element: Comparable>: MutableCollection,
                                                ExpressibleByArrayLiteral,
                                                DefaultConstructible,
                                                Equatable,
                                                SequenceConstructible {

  public typealias SubSequence = ArraySlice<Element>
  public typealias Index = Int

  //todo fileprivate?
  internal
  var content: [Element] {
    didSet {
      content = content.sorted()
    }
  }

  public init() {
    content = []
  }

  public init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    content = seq.sorted()
  }

  public init(arrayLiteral elements: Element...) {
    content = elements.sorted()
  }

  public var startIndex: Index {
    return content.startIndex
  }

  public var endIndex: Index {
    return content.endIndex
  }

  public subscript (index: Index) -> Element {
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
      replaceSubrange(bounds, with: newValue)
    }
  }

  public func index(after index: Index) -> Index {
    return content.index(after: index)
  }

  public func index(of element: Element) -> Index? {
//    fatalError("implement")
    //todo actually do binary search lol
    return content.index(of: element)
//    return nil
  }
}

extension SortedArray {
  public func sorted() -> [Element] {
    return content
  }

  public func sort() {
    return
  }
}

extension SortedArray: RangeReplaceableCollection {
  public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Element {
    //
    // todo: optimize, check if the subrange.count == newelements.count
    //
    content.replaceSubrange(subrange, with: newElements)
  }

  public mutating func append<S: Sequence>(contentsOf newElements: S) where S.Iterator.Element == Element {
    content.append(contentsOf: newElements)
//    content = content.sorted()
  }
}

extension SortedArray: CustomStringConvertible {
  public var description: String {
    return "SortedArray(\(content))"
  }
}

extension SortedArray: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    return content.index(before: index)
  }
}

extension SortedArray: RandomAccessCollection {
  public typealias Indices = Array<Element>.Indices
}

public func ==<Element>(lhs: SortedArray<Element>, rhs: SortedArray<Element>) -> Bool {
  return lhs.content == rhs.content
}

