//
//  ArrayDiff.swift
//
//  Created by Eduardo Arenas on 1/1/17.
//  Licensed Under MIT. See https://github.com/eduarenas/SwiftArrayDiff/blob/master/LICENSE.
//

import Foundation

struct DiffItem<T> {
  let index: Int
  let element: T
}

struct Diff<T> {
  let additions: [DiffItem<T>]
  let deletions: [DiffItem<T>]
}

extension Array where Element: Equatable {

  func diff(other: Array<Element>) -> Diff<Element> {
    let reducedArrays = nonMatchingSubArray(old: self, new: other)
    let lcsTable = lcsLengthTable(old: reducedArrays.old, new: reducedArrays.new)
    return diffFromLCSTable(table: lcsTable, old: reducedArrays.old, new: reducedArrays.new, indexOffset: reducedArrays.startIndex)
  }
}

private func nonMatchingSubArray<T: Equatable>(old: [T], new: [T]) -> (old: [T], new: [T], startIndex: Int) {
  guard old.count > 0 && new.count > 0 else {
    return (old, new, 0)
  }
  var startIndex = 0
  var oldEndIndex = old.count - 1
  var newEndIndex = new.count - 1

  while startIndex < oldEndIndex && startIndex < newEndIndex && old[startIndex] == new[startIndex] {
    startIndex += 1
  }

  while oldEndIndex > startIndex && newEndIndex > startIndex && old[oldEndIndex] == new[newEndIndex] {
    oldEndIndex -= 1
    newEndIndex -= 1
  }

  return (Array(old[startIndex...oldEndIndex]), Array(new[startIndex...newEndIndex]), startIndex)
}

private struct TableItem {
  let length: Int
  let previousIndex: (x: Int, y: Int)?
}

private func lcsLengthTable<T: Equatable>(old: [T], new: [T]) -> [[TableItem]] {
  let n = old.count
  let m = new.count
  var table = Array<[TableItem]>(repeating: Array(repeating: TableItem(length: 0, previousIndex: nil), count: m + 1), count: n + 1)

  for i in 0...n {
    for j in 0...m {
      if i == 0 && j == 0 {
        table[i][j] = TableItem(length: 0, previousIndex: nil)
      } else if i == 0 {
        table[i][j] = TableItem(length: 0, previousIndex: (i, j - 1))
      } else if j == 0 {
        table[i][j] = TableItem(length: 0, previousIndex: (i - 1, j))
      } else if old[i - 1] == new[j - 1] {
        table[i][j] = TableItem(length: table[i - 1][j - 1].length + 1, previousIndex: (i - 1, j - 1))
      } else {
        if table[i][j - 1].length >= table[i - 1][j].length {
          table[i][j] = TableItem(length: table[i][j - 1].length, previousIndex: (i, j - 1))
        } else {
          table[i][j] = TableItem(length: table[i - 1][j].length, previousIndex: (i - 1, j))
        }
      }
    }
  }

  return table
}

private func diffFromLCSTable<T: Equatable>(table: [[TableItem]], old: [T], new: [T], indexOffset: Int) -> Diff<T> {
  var currentIndex = (x: table.count - 1, y: table[0].count - 1)
  var currentItem = table[currentIndex.x][currentIndex.y]

  var additions = [DiffItem<T>]()
  var deletions = [DiffItem<T>]()

  while let previousIndex = currentItem.previousIndex {

    if previousIndex.x == currentIndex.x && previousIndex.y < currentIndex.y {
      additions.append(DiffItem(index: currentIndex.y - 1 + indexOffset, element: new[currentIndex.y - 1]))
    } else if previousIndex.x < currentIndex.x && previousIndex.y == currentIndex.y {
      deletions.append(DiffItem(index: currentIndex.x - 1 + indexOffset, element: old[currentIndex.x - 1]))
    }

    currentIndex = previousIndex
    currentItem = table[currentIndex.x][currentIndex.y]
  }

  return Diff(additions: additions, deletions: deletions)
}
