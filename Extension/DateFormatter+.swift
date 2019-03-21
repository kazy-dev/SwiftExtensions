import Foundation

extension DateFormatter {

    /// 端末設定書式のDateFormatterを取得する。
    ///
    /// - Returns: DateFormatter
    public static func current() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    /// 固定書式のDateFormatterを取得する。
    ///
    /// - Returns: DateFormatter
    public static func gmt() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}

// MARK: - String

extension DateFormatter {

    /// Dateを文字列に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - format: 変換形式
    /// - Returns: 変換結果
    public func string(from date: Date, format: String) -> String {
        dateFormat = format
        return string(from: date)
    }

    /// Dateを文字列に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func string(from date: Date,
                       dateStyle: DateFormatter.Style = .medium,
                       timeStyle: DateFormatter.Style = .medium) -> String {
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        return string(from: date)
    }

    /// Dateを文字列に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - template: 変換形式
    /// - Returns: 変換結果
    public func string(from date: Date, template: String) -> String {
        dateFormat = ""
        if let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) {
            dateFormat = format
        }
        return string(from: date)
    }

    /// Dateを文字列(GMT)に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - format: 変換形式
    /// - Returns: 変換結果
    public func gmtString(from date: Date, format: String) -> String {
        return DateFormatter.gmt().string(from: date, format: format)
    }

    /// Dateを文字列(GMT)に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func gmtString(from date: Date,
                          dateStyle: DateFormatter.Style = .medium,
                          timeStyle: DateFormatter.Style = .medium) -> String {
        return DateFormatter.gmt().string(from: date, dateStyle: dateStyle, timeStyle: dateStyle)
    }

    /// Dateを文字列(GMT)に変換する。
    ///
    /// - Parameters:
    ///   - date: Dateオブジェクト
    ///   - format: 変換形式
    /// - Returns: 変換結果
    public func gmtString(from date: Date, template: String) -> String {
        return DateFormatter.gmt().string(from: date, template: template)
    }
}

// MARK: - Date

extension DateFormatter {

    /// 指定形式の日付文字列をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - format: 変換形式
    /// - Returns: 変換結果
    public func date(from str: String, format: String) -> Date? {
        dateFormat = format
        return date(from: str)
    }

    /// 指定形式の日付文字列をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func date(from str: String,
                     dateStyle: DateFormatter.Style,
                     timeStyle: DateFormatter.Style) -> Date? {
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        return date(from: str)
    }

    /// 指定形式の日付文字列をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - template: 変換形式
    /// - Returns: 変換結果
    public func date(from str: String, template: String) -> Date? {
        dateFormat = ""
        if let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) {
            dateFormat = format
        }
        return date(from: str)
    }

    /// 指定形式の日付文字列(GMT)をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - format: 変換形式
    /// - Returns: 変換結果
    public func date(fromGMT str: String, format: String) -> Date? {
        return DateFormatter.gmt().date(from: str, format: format)
    }

    /// 指定形式の日付文字列(GMT)をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - dateStyle: 日付書式
    ///   - timeStyle: 時刻書式
    /// - Returns: 変換結果
    public func date(fromGMT str: String,
                     dateStyle: DateFormatter.Style,
                     timeStyle: DateFormatter.Style) -> Date? {
        return DateFormatter.gmt().date(from: str, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    /// 指定形式の日付文字列(GMT)をDateに変換する。
    ///
    /// - Parameters:
    ///   - str: Stringオブジェクト
    ///   - template: 変換形式
    /// - Returns: 変換結果
    public func date(fromGMT str: String, template: String) -> Date? {
        return DateFormatter.gmt().date(from: str, template: template)
    }
}
