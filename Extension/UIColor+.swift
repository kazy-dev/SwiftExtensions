import UIKit

// MARK: - Initialize

extension UIColor {

    /// 16進数表記からUIColorを作成する。
    /// 失敗した場合は白色
    ///
    /// - Parameters:
    ///   - hexString: 16進数表記のRGB (000000~FFFFFF)
    ///   - alpha: alpha値 (0.0~1.0)
    convenience init?(hexString: String, alpha: Double = 1.0) {
        var color: UInt32 = 0
        guard Scanner(string: hexString.replacingOccurrences(of: "#", with: "")).scanHexInt32(&color) else {
            return nil
        }
        self.init(red: CGFloat((color & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(color & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha))
    }

    /// 16進数表記からUIColorを作成する。
    ///
    /// - Parameters:
    ///   - hex: 16進数表記のRGB (0x000000~0xFFFFFF)
    ///   - alpha: alpha値 (0.0~1.0)
    convenience init(hex: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hex & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha))
    }

    /// 10進数表記からUIColorを作成する。
    ///
    /// - Parameters:
    ///   - red: 赤 (0~255)
    ///   - green: 緑 (0~255)
    ///   - blue: 青 (0~255)
    ///   - alpha: alpha値 (0.0~1.0)
    @nonobjc
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: CGFloat(alpha))
    }
}

// MARK: - Edit

extension UIColor {

    /// 色相を変更する。
    ///
    /// - Parameter hue: 色相 (0.0~1.0)
    /// - Returns: 変更後のUIColor
    public func hue(_ hue: CGFloat) -> UIColor {
        var _hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        guard getHue(&_hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return self
        }
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// 彩度を変更する。
    ///
    /// - Parameter saturation: 彩度 (0.0~1.0)
    /// - Returns: 変更後のUIColor
    public func saturation(_ saturation: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var _saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        guard getHue(&hue, saturation: &_saturation, brightness: &brightness, alpha: &alpha) else {
            return self
        }
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// 透過率を変更する。
    ///
    /// - Parameter alpha: 透過率 (0.0~1.0)
    /// - Returns: 変更後のUIColor
    public func alpha(_ alpha: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var _alpha: CGFloat = 0.0
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &_alpha) else {
            return self
        }
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// 明るさを変更する。
    ///
    /// - Parameter brightness: 明るさ (0.0~1.0)
    /// - Returns: 変更後のUIColor
    public func brightness(_ brightness: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        var _brightness: CGFloat = 0.0
        guard getHue(&hue, saturation: &saturation, brightness: &_brightness, alpha: &alpha) else {
            return self
        }
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
