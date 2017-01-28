//
//  ArrayDiffTests.swift
//
//  Created by Eduardo Arenas on 10/16/16.
//  Licensed Under MIT. See https://github.com/eduarenas/SwiftArrayDiff/blob/master/LICENSE.
//
import XCTest
@testable import TennisScoring

class ArrayDiffTests: XCTestCase {

  func testCompleteInsertion() {
    let diff = [Int]().diff(other: [1, 2, 3])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 3}))
  }

  func testCompleteDeletion() {
    let diff = [1, 2, 3].diff(other: [])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
  }

  func testSingleMiddleInsertion() {
    let diff = [1, 3, 4].diff(other: [1, 2, 3, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertEqual(diff.additions[0].index, 1)
    XCTAssertEqual(diff.additions[0].element, 2)
  }

  func testSingleMiddleDeletion() {
    let diff = [1, 2, 3, 4].diff(other: [1, 2, 4])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.deletions[0].index, 2)
    XCTAssertEqual(diff.deletions[0].element, 3)
  }

  func testSingleMiddleReplacement() {
    let diff = [1, 3, 4].diff(other: [1, 2, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.additions[0].index, 1)
    XCTAssertEqual(diff.additions[0].element, 2)
    XCTAssertEqual(diff.deletions[0].index, 1)
    XCTAssertEqual(diff.deletions[0].element, 3)
  }

  func testSingleStartInsertion() {
    let diff = [2, 3, 4].diff(other: [1, 2, 3, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertEqual(diff.additions[0].index, 0)
    XCTAssertEqual(diff.additions[0].element, 1)
  }

  func testSingleStartDeletion() {
    let diff = [1, 2, 3, 4].diff(other: [2, 3, 4])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.deletions[0].index, 0)
    XCTAssertEqual(diff.deletions[0].element, 1)
  }

  func testSingleStartReplacement() {
    let diff = [1, 3, 4].diff(other: [2, 3, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.additions[0].index, 0)
    XCTAssertEqual(diff.additions[0].element, 2)
    XCTAssertEqual(diff.deletions[0].index, 0)
    XCTAssertEqual(diff.deletions[0].element, 1)
  }

  func testSingleEndInsertion() {
    let diff = [1, 2, 3].diff(other: [1, 2, 3, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertEqual(diff.additions[0].index, 3)
    XCTAssertEqual(diff.additions[0].element, 4)
  }

  func testSingleEndDeletion() {
    let diff = [1, 2, 3, 4].diff(other: [1, 2, 3])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.deletions[0].index, 3)
    XCTAssertEqual(diff.deletions[0].element, 4)
  }

  func testSingleEndReplacement() {
    let diff = [1, 2, 3].diff(other: [1, 2, 4])
    XCTAssertEqual(diff.additions.count, 1)
    XCTAssertEqual(diff.deletions.count, 1)
    XCTAssertEqual(diff.additions[0].index, 2)
    XCTAssertEqual(diff.additions[0].element, 4)
    XCTAssertEqual(diff.deletions[0].index, 2)
    XCTAssertEqual(diff.deletions[0].element, 3)
  }

  func testMultipleConsecutiveMiddleInsertion() {
    let diff = [1, 2, 3].diff(other: [1, 2, 4, 5, 6, 3])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 4}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 5}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 6}))
  }

  func testMultipleConsecutiveMiddleDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 5, 6])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
  }

  func testMultipleConsecutiveMiddleReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 2, 7, 8, 9, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 4 && $0.element == 5}))
  }

  func testMultipleNonConsecutiveMiddleInsertion() {
    let diff = [1, 2, 3].diff(other: [1, 4, 5, 2, 6, 3])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 4}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 5}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 6}))
  }

  func testMultipleNonConsecutiveMiddleDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 4, 6])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 4 && $0.element == 5}))
  }

  func testMultipleNonConsecutiveMiddleReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 7, 8, 4, 9, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 4 && $0.element == 5}))
  }

  func testMultiplConsecutiveStartInsertion() {
    let diff = [4, 5, 6].diff(other: [1, 2, 3, 4, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 3}))
  }

  func testMultipleConsecutiveStartDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [4, 5, 6])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
  }

  func testMultipleConsecutiveStartReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [7, 8, 9, 4, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 0 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
  }

  func testMultipleNonConsecutiveStartInsertion() {
    let diff = [4, 5, 6].diff(other: [1, 2, 4, 3, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 3}))
  }

  func testMultipleNonConsecutiveStartDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [3, 5, 6])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
  }

  func testMultipleNonConsecutiveStartReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [7, 8, 3, 9, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 0 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 1 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 1 && $0.element == 2}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
  }

  func testMultiplConsecutiveEndInsertion() {
    let diff = [1, 2, 3].diff(other: [1, 2, 3, 4, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 5}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testMultipleConsecutiveEndDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 2, 3])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 4 && $0.element == 5}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testMultipleConsecutiveEndReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 2, 3, 7, 8, 9])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 5 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 4 && $0.element == 5}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testMultipleNonConsecutiveEndInsertion() {
    let diff = [1, 2, 4].diff(other: [1, 2, 3, 4, 5, 6])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 0)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 4 && $0.element == 5}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testMultipleNonConsecutiveEndDeletion() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 2, 5])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testMultipleNonConsecutiveEndReplacement() {
    let diff = [1, 2, 3, 4, 5, 6].diff(other: [1, 2, 7, 8, 5, 9])
    XCTAssertEqual(diff.additions.count, 3)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 2 && $0.element == 7}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 3 && $0.element == 8}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 5 && $0.element == 9}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 2 && $0.element == 3}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 3 && $0.element == 4}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 5 && $0.element == 6}))
  }

  func testDuplicatedMidSectionDeletion() {
    let diff = [1, 2, 3, 3, 3, 5, 6].diff(other: [1, 2, 3, 5, 6])
    XCTAssertEqual(diff.additions.count, 0)
    XCTAssertEqual(diff.deletions.count, 2)
    XCTAssertEqual(diff.deletions.filter({ $0.index >= 2 && $0.index <= 4 }).count, 2)
    XCTAssertEqual(diff.deletions.filter({ $0.element == 3 }).count, 2)
  }

  func testLargeSequenceDiff() {
    let old = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]

    let new = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 55, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101]

    let diff = old.diff(other: new)

    XCTAssertEqual(diff.additions.count, 2)
    XCTAssertEqual(diff.deletions.count, 3)
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 0 && $0.element == 1}))
    XCTAssertTrue(diff.deletions.contains(where: { $0.index == 44 && $0.element == 45}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 53 && $0.element == 55}))
    XCTAssertTrue(diff.additions.contains(where: { $0.index == 98 && $0.element == 101}))
  }

//  func testLargeSequenceDiffPerformance() {
//    let old = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
//
//    let new = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 55, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101]
//
//    measure() {
//      let _ = old.diff(other: new)
//    }
//  }
//
//  func testHugeSequenceDiffPerformanceWhenEqual() {
//    let old = Array(1...5000)
//    let new = Array(1...5000)
//
//    measure() {
//      let _ = old.diff(other: new)
//    }
//  }
//
//
//  func testHugeSequenceDiffPerformanceWithProximateChanges() {
//    let old = Array(1...5000)
//    var new = Array(1...5000)
//
//    new.removeSubrange(3000...3003)
//    new.insert(contentsOf: [5000, 50001], at: 3005)
//
//    measure() {
//      let _ = old.diff(other: new)
//    }
//  }
//
//  func testHugeSequenceDiffPerformanceWithASparseChanges() {
//    let old = Array(1...5000)
//    var new = Array(1...5000)
//
//    new.remove(at: 2)
//    new.insert(contentsOf: [5000, 50001], at: 4985)
//    new.replaceSubrange(2500...2503, with: [6000, 60001, 60002])
//
//    measure() {
//      let _ = old.diff(other: new)
//    }
//  }
}
