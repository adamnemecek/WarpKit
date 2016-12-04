//
//  MIDITrack.swift
//  WarpKit
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import Foundation
import WarpKit
import AVFoundation

public protocol Temporal {
    associatedtype Timestamp: Comparable
}

public class MIDITrackIterator<T: Temporal>: IteratorProtocol {
    internal let ref: MusicEventIterator

    public init(ref: MusicTrack) {
        fatalError()
    }

    public func next() -> T? {
        fatalError()
    }
}

public struct MIDITrackSlice<T: Temporal>: Sequence {
    public typealias Timestamp = T.Timestamp

    public let range: ClosedRange<Timestamp>

    let base: MIDITrackRef<T>

    init(base: MIDITrackRef<T>, range: ClosedRange<Timestamp>) {
        self.base = base
        self.range = range
    }

    public func makeIterator() -> AnyIterator<T> {
        var i = MIDITrackIterator<T>(ref: base.ref)
        return AnyIterator {
            return nil
//            i.next().flatMap { self.range.contains($0.timestamp) ? $0 : nil }
        }
    }

//    public func index(after i: Index) -> Index {
//        return i + 1
//    }

}

class MIDITrackRef<T: Temporal>: Sequence {
    internal let ref: MusicTrack

    init(ref: MusicTrack) {
        self.ref = ref
    }

    func makeIterator() -> AnyIterator<T> {
        fatalError()
    }

    func filter(_ isIncluded: (T) throws -> Bool) rethrows -> [T] {
        fatalError()
    }
}

//struct MIDITrack<T: Temporal>: Collection {
//    private var content: TimeSeries<T> = []
//    private var ref: MIDITrackRef<T>
//
//    public typealias Index = Int
//
//    public init(ref: MIDITrackRef<T>) {
//        self.ref = ref
//        self.content = TimeSeries(ref)
//    }
//
//    public var startIndex: Index {
//        return content.startIndex
//    }
//
//    public var endIndex: Index {
//        return content.endIndex
//    }
//
//    public func index(after index: Index) -> Index {
//        return content.index(after: index)
//    }
//
//    public subscript (index: Index) -> T {
//        return content[index]
//    }
//
//}
