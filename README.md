# SwiftArrayDiff
Swift Array extension to  calculate the differences between two arrays of Equatable items using the dynamic programming algorithm to solve the [longest common subsequence problem](https://en.wikipedia.org/wiki/Longest_common_subsequence_problem). Currently this algorithm only calculates insertions and deletions.

This is useful for animating insertions and deletions of multiple elements in a `UITableView` or `UICollectionView`:

```
let diff = oldList.diff(other: newList)
let removedIndexPaths = diff.deletions.map { IndexPath(row: $0.index, section: 0) }
let insertedIndexPaths = diff.additions.map { IndexPath(row: $0.index, section: 0) }
self.tableView.beginUpdates()
self.tableView.deleteRows(at: removedIndexPaths, with: .automatic)
self.tableView.insertRows(at: insertedIndexPaths, with: .automatic)
self.tableView.endUpdates()
```
