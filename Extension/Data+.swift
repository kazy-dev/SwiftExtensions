import Foundation
import CommonCrypto

// MARK: - Bundle

extension Data {

    public init?(forResource name: String?, withExtension ext: String?) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            return nil
        }
        try? self.init(contentsOf: url)
    }

    public init?(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext, subdirectory: subpath) else {
            return nil
        }
        try? self.init(contentsOf: url)
    }

    public init?(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?, localization localizationName: String?) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext, subdirectory: subpath, localization: localizationName) else {
            return nil
        }
        try? self.init(contentsOf: url)
    }
}

extension Data {
}

// MARK: - NSData

extension Data {

    public init?(contentsOfFile path: String) {
        guard let data = try? NSData(contentsOfFile: path) as Data else {
            return nil
        }
        self = data
    }

    public var bytes: UnsafeRawPointer {
        return nsData.bytes
    }

    public func getBytes(_ bytes: UnsafeMutableRawPointer, count: Int) {
        nsData.getBytes(bytes, length: count)
    }

    private var nsData: NSData {
        return self as NSData
    }
}

// MARK: - CommonCrypt

extension Data {

    public var md5: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_MD5($0, CC_LONG(count), &digest) })
        return digest
    }

    public var sha1: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_SHA1($0, CC_LONG(CC_SHA1_DIGEST_LENGTH), &digest) })
        return digest
    }

    public var sha256: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_SHA256($0, CC_LONG(CC_SHA256_DIGEST_LENGTH), &digest) })
        return digest
    }

    public var sha224: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_SHA224($0, CC_LONG(CC_SHA224_DIGEST_LENGTH), &digest) })
        return digest
    }

    public var sha384: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_SHA384($0, CC_LONG(CC_SHA384_DIGEST_LENGTH), &digest) })
        return digest
    }

    public var sha512: [UInt8] {
        var digest = [UInt8](repeating: 0, count: count)
        let _ = withUnsafeBytes({ CC_SHA512($0, CC_LONG(CC_SHA512_DIGEST_LENGTH), &digest) })
        return digest
    }
}
