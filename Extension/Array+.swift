import Foundation

// MARK: - Remove

extension Array where Element: Equatable {

    /// オブジェクトを削除する。
    ///
    /// - Parameter object: オブジェクト
    public mutating func remove(of object: Element) {
        guard let index = index(of: object) else {
            return
        }
        remove(at: index)
    }

    /// オブジェクトを削除する。
    ///
    /// - Parameter objects: オブジェクト
    public mutating func remove(of objects: [Element]) {
        objects.forEach({ remove(of: $0) })
    }
}
