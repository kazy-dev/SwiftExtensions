import Foundation

// MARK: - Properties

extension String {

    /// Localizable.stringsの同名keyから文字列を取得する。
    public var localized: String? {
        return NSLocalizedString(self, comment: self)
    }

    /// 16進数文字列からIntを取得する。
    public var hexInt: UInt32? {
        var result: UInt32 = 0
        guard Scanner(string: self).scanHexInt32(&result) else {
            return nil
        }
        return result
    }
}

// MARK: - Bundle

extension String {

    public init?(pathForBundleText: String, encoding: String.Encoding = .utf8) {
        guard let data = Data(forResource: pathForBundleText, withExtension: "txt") else {
            return nil
        }
        self.init(data: data, encoding: encoding)
    }

    public init?(pathForBundleText: String, subdirectory subpath: String?, encoding: String.Encoding = .utf8) {
        guard let data = Data(forResource: pathForBundleText, withExtension: "txt", subdirectory: subpath) else {
            return nil
        }
        self.init(data: data, encoding: encoding)
    }

    public init?(pathForBundleText: String, subdirectory subpath: String?, localization localizationName: String?, encoding: String.Encoding = .utf8) {
        guard let data = Data(forResource: pathForBundleText, withExtension: "txt", subdirectory: subpath, localization: localizationName) else {
            return nil
        }
        self.init(data: data, encoding: encoding)
    }
}

// MARK: - Date

extension String {

    public init(date: Date, format: String, toGMT: Bool = false) {
        self.init()

        let formatter = toGMT ? DateFormatter.gmt() : DateFormatter.current()
        self = formatter.string(from: date, format: format)
    }

    public init(date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, toGMT: Bool = false) {
        self.init()

        let formatter = toGMT ? DateFormatter.gmt() : DateFormatter.current()
        self = formatter.string(from: date, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    public init(date: Date, template: String, toGMT: Bool = false) {
        self.init()

        let formatter = toGMT ? DateFormatter.gmt() : DateFormatter.current()
        self = formatter.string(from: date, template: template)
    }
}

// MARK: - Number

extension String {

    public init?(_ integer: Int, format: String) {
        self.init()

        guard let str = numberFormat(number: NSNumber(value: integer), format: format) else {
            return nil
        }
        self = str
    }

    public init?(_ float: Float, format: String) {
        self.init()

        guard let str = numberFormat(number: NSNumber(value: float), format: format) else {
            return nil
        }
        self = str
    }

    public init?(_ double: Double, format: String) {
        self.init()

        guard let str = numberFormat(number: NSNumber(value: double), format: format) else {
            return nil
        }
        self = str
    }

    /// 数値の表示フォーマット。
    ///
    /// - Parameters:
    ///   - number: 数値
    ///   - format: フォーマット形式
    /// - Returns: 文字列
    private func numberFormat(number: NSNumber, format: String) -> String? {
        let formatter = NumberFormatter()
        formatter.positiveFormat = format
        return formatter.string(from: number)
    }
}

// MARK: - URL

extension String {

    /// URLに変換する。
    ///
    /// - Returns: 変換結果
    public func url() -> URL? {
        return URL(string: self)
    }
}

// MARK: - NSString

extension String {

    public var pathExtension: String {
        return nsString.pathExtension
    }

    public var deletingLastPathComponent: String {
        return nsString.deletingLastPathComponent
    }

    public var deletingPathExtension: String {
        return nsString.deletingPathExtension
    }

    public var pathComponents: [String] {
        return nsString.pathComponents
    }

    public var lastPathComponent: String {
        return nsString.lastPathComponent
    }

    public func substring(with range: NSRange) -> String {
        return nsString.substring(with: range)
    }

    public func appendingPathComponent(_ str: String) -> String {
        return nsString.appendingPathComponent(str)
    }

    public func appendingPathExtension(_ str: String) -> String? {
        return nsString.appendingPathExtension(str)
    }

    private var nsString: NSString {
        return self as NSString
    }
}

// MARK: - Substring

extension String {
    
    func substring(_ r: CountableRange<Int>) -> String {
        
        let length = self.count
        let fromIndex = (r.startIndex > 0) ? self.index(self.startIndex, offsetBy: r.startIndex) : self.startIndex
        let toIndex = (length > r.endIndex) ? self.index(self.startIndex, offsetBy: r.endIndex) : self.endIndex
        
        if fromIndex >= self.startIndex && toIndex <= self.endIndex {
            return String(self[fromIndex..<toIndex])
        }
        
        return String(self)
    }
    
    func substring(_ r: CountableClosedRange<Int>) -> String {
        
        let from = r.lowerBound
        let to = r.upperBound
        
        return self.substring(from..<(to+1))
    }
    
    func substring(_ r: CountablePartialRangeFrom<Int>) -> String {
        
        let from = r.lowerBound
        let to = self.count
        
        return self.substring(from..<to)
    }
    
    func substring(_ r: PartialRangeThrough<Int>) -> String {
        
        let from = 0
        let to = r.upperBound
        
        return self.substring(from..<to)
    }
}

// MARK: - Regular expression

extension String {

    /// 正規表現チェック。
    /// 完全一致でtrueを返す。
    ///
    /// - Parameters:
    ///   - pattern: 条件
    ///   - options: 検索オプション
    /// - Returns: 結果
    public func equals(pattern: String,
                       options: NSRegularExpression.Options = [.anchorsMatchLines]) -> Bool {
        guard let matches = regex(pattern, options: options) else {
            return false
        }
        return matches.count == 1
    }

    /// 正規表現チェック。
    /// 部分一致でtrueを返す。
    ///
    /// - Parameters:
    ///   - pattern: 条件
    ///   - options: 検索オプション
    /// - Returns: 結果
    public func contains(pattern: String, options: NSRegularExpression.Options = [.anchorsMatchLines]) -> Bool {
        guard let matches = regex(pattern, options: options) else {
            return false
        }
        return !matches.isEmpty
    }

    /// 正規表現チェック。
    /// 一致箇所を配列で返す。
    ///
    /// - Parameter pattern: 条件
    /// - Returns: 結果
    public func matches(_ pattern: String, options: NSRegularExpression.Options = [.anchorsMatchLines]) -> [String] {
        var matches = [String]()
        regex(pattern, options: options)?.forEach({
            for i in 0 ..< $0.numberOfRanges {
                let range = $0.range(at: i)
                guard range.location != NSNotFound else {
                    continue
                }
                matches.append((self as NSString).substring(with: NSRange(location: range.location, length: range.length)))
            }
        })
        return matches
    }

    /// 正規表現で置換。
    ///
    /// - Parameters:
    ///   - pattern: 条件
    ///   - withPattern: 置換文字
    ///   - options: 検索オプション
    /// - Returns: 結果
    public func replacingOccurrences(pattern: String, withPattern: String) -> String {
        return replacingOccurrences(
                of: pattern,
                with: withPattern,
                options: .regularExpression,
                range: self.range(of: self))
    }

    /// URLチェック。
    ///
    /// - Returns: 結果
    public func checkUrls() -> [URL] {
        var urls: [URL] = [URL]()
        detect(types: NSTextCheckingResult.CheckingType.link.rawValue)?.forEach({
            if let url = $0.url {
                urls.append(url)
            }
        })
        return urls
    }

    /// 電話番号チェック。
    ///
    /// - Returns: 結果
    public func checkPhoneNumbers() -> [String] {
        var phoneNumbers: [String] = [String]()
        detect(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)?.forEach({
            if let phoneNumber = $0.phoneNumber {
                phoneNumbers.append(phoneNumber)
            }
        })
        return phoneNumbers
    }

    /// 正規表現チェック。
    ///
    /// - Parameters:
    ///   - pattern: 条件
    ///   - options: 検索オプション
    /// - Returns: 結果
    private func regex(_ pattern: String, options: NSRegularExpression.Options = [.anchorsMatchLines]) -> [NSTextCheckingResult]? {
        return try? NSRegularExpression(pattern: pattern,
                                        options: options)
            .matches(in: self, options: [], range: NSRange(location: 0, length: count))
    }

    /// 文字列チェック。
    ///
    /// - Parameter types: チェックする種類
    /// - Returns: 結果
    private func detect(types: NSTextCheckingTypes) -> [NSTextCheckingResult]? {
        return try? NSDataDetector(types: types)
            .matches(in: self, options: [], range: NSRange(location: 0, length: count))
    }
}
