import Foundation

// MARK: - Initialize

extension Date {

    public init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0, timeZone: TimeZone = TimeZone.current) {
        var component = DateComponents()
        component.year = year
        component.month = month
        component.day = day
        component.hour = hour
        component.minute = minute
        component.second = second
        component.nanosecond = nanosecond
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        guard let date = calendar.date(from: component) else {
            return nil
        }
        self = date
    }

    public init?(from: String, format: String) {
        guard let date = DateFormatter.current().date(from: from, format: format) else {
            return nil
        }
        self.init()
        self = date
    }

    public init?(from: String, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        guard let date = DateFormatter.current().date(from: from, dateStyle: dateStyle, timeStyle: timeStyle) else {
            return nil
        }
        self.init()
        self = date
    }

    public init?(from: String, template: String) {
        guard let date = DateFormatter.current().date(from: from, template: template) else {
            return nil
        }
        self.init()
        self = date
    }

    public init?(fromGMT: String, format: String) {
        guard let date = DateFormatter.gmt().date(from: fromGMT, format: format) else {
            return nil
        }
        self.init()
        self = date
    }

    public init?(fromGMT: String, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        guard let date = DateFormatter.gmt().date(from: fromGMT, dateStyle: dateStyle, timeStyle: timeStyle) else {
            return nil
        }
        self.init()
        self = date
    }

    public init?(fromGMT: String, template: String) {
        guard let date = DateFormatter.gmt().date(from: fromGMT, template: template) else {
            return nil
        }
        self.init()
        self = date
    }
}

// MARK: - String

extension Date {

    /// 文字列に変換する。
    ///
    /// - Parameter format: 変換形式
    /// - Returns: 変換結果
    public func string(format: String) -> String {
        return DateFormatter.current().string(from: self, format: format)
    }

    /// 文字列に変換する。
    ///
    /// - Parameters:
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func string(dateStyle: DateFormatter.Style,
                       timeStyle: DateFormatter.Style) -> String {
        return DateFormatter.current().string(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    /// 文字列に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - template: 変換形式
    /// - Returns: 変換結果
    public func string(template: String) -> String {
        return DateFormatter.current().string(from: self, template: template)
    }

    /// 文字列(GMT)に変換する。
    ///
    /// - Parameter format: 変換形式
    /// - Returns: 変換結果
    public func gmtString(format: String) -> String {
        return DateFormatter.gmt().string(from: self, format: format)
    }

    /// 文字列(GMT)に変換する。
    ///
    /// - Parameters:
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func gmtString(dateStyle: DateFormatter.Style,
                          timeStyle: DateFormatter.Style) -> String {
        return DateFormatter.gmt().string(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    /// 文字列(GMT)に変換する。
    ///
    /// - Parameter template: 変換形式
    /// - Returns: 変換結果
    public func gmtString(template: String) -> String {
        return DateFormatter.gmt().string(from: self, template: template)
    }
}

// MARK: - Compare

extension Date {

    /// 日付の範囲内かどうかを確認する。
    ///
    /// - Parameters:
    ///   - from: 比較するDate
    ///   - to: 比較するDate
    ///   - includes: 比較するDateと同時刻の場合に範囲内と判定するかどうか
    /// - Returns: 確認結果
    public func isIn(from: Date, to: Date, includes: Bool = false) -> Bool {
        return isFuture(from, includes: includes) && isBefore(to, includes: includes)
    }

    /// 昨日かどうかを確認する。
    ///
    /// - Parameter date: 確認するDate
    /// - Returns: 確認結果
    public static func isYesterday(_ date: Date, timeZone: TimeZone = TimeZone.current) -> Bool {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar.isDateInYesterday(date)
    }

    /// 昨日かどうかを確認する。
    ///
    /// - Returns: 確認結果
    public func isYesterday(timeZone: TimeZone = TimeZone.current) -> Bool {
        return Date.isYesterday(self, timeZone: timeZone)
    }

    /// 明日かどうかを確認する。
    ///
    /// - Parameter date: 確認するDate
    /// - Returns: 確認結果
    public static func isTommorow(_ date: Date, timeZone: TimeZone = TimeZone.current) -> Bool {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar.isDateInTomorrow(date)
    }

    /// 明日かどうかを確認する。
    ///
    /// - Returns: 確認結果
    public func isTommorow(timeZone: TimeZone = TimeZone.current) -> Bool {
        return Date.isTommorow(self, timeZone: timeZone)
    }

    /// 比較するDateより過去かどうかを比較する。
    /// 過去ならtrueを返す。
    ///
    /// - Parameters:
    ///   - date: 比較するDate
    ///   - includes: 比較するDateと同時刻の場合に過去と判定するかどうか
    /// - Returns: 比較結果。
    public func isBefore(_ date: Date, includes: Bool = false) -> Bool {
        guard self != date else {
            return includes
        }
        return self < date
    }

    /// 比較するDateより未来かどうかを比較する。
    /// 未来ならtrueを返す。
    ///
    /// - Parameters:
    ///   - date: 比較するDate
    ///   - includes: 比較するDateと同時刻の場合に未来と判定するかどうか
    /// - Returns: 比較結果。
    public func isFuture(_ date: Date, includes: Bool = false) -> Bool {
        guard self != date else {
            return includes
        }
        return self > date
    }
}

// MARK: - Component

extension Date {

    /// 昨日の日付を取得する。
    ///
    /// - Returns: 昨日の日付
    public func yesterday() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    /// 翌日の日付を取得する。
    ///
    /// - Returns: 翌日の日付
    public func tomorrow() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    /// 指定日数前の日付を取得する。
    ///
    /// - Parameter day: 日数
    /// - Returns: 指定日数前の日付
    public func before(day: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -day, to: self)
    }

    /// 指定月数前の日付を取得する。
    ///
    /// - Parameter month: 月数
    /// - Returns: 指定月数前の日付
    public func before(month: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: -month, to: self)
    }

    /// 指定年数前の日付を取得する。
    ///
    /// - Parameter year: 年数
    /// - Returns: 指定年数前の年付
    public func before(year: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: -year, to: self)
    }

    /// 指定日数後の日付を取得する。
    ///
    /// - Parameter day: 日数
    /// - Returns: 指定日数後の日付
    public func future(day: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: day, to: self)
    }

    /// 指定月数後の日付を取得する。
    ///
    /// - Parameter month: 月数
    /// - Returns: 指定月数後の日付
    public func future(month: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: month, to: self)
    }

    /// 指定年数後の日付を取得する。
    ///
    /// - Parameter year: 年数
    /// - Returns: 指定年数後の日付
    public func future(year: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: year, to: self)
    }

    /// DateComponentsを取得する。
    ///
    /// - Parameters:
    ///   - components: Calendar.Component
    ///   - timeZone: TimeZone
    /// - Returns: DateComponents
    public func dateComponents(components: Set<Calendar.Component>, timeZone: TimeZone = TimeZone.current) -> DateComponents {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar.dateComponents(components, from: self)
    }
}
