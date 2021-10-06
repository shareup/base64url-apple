import Foundation

private let plusAscii = Character("+").asciiValue!
private let slashAscii = Character("/").asciiValue!
private let hyphenAscii = Character("-").asciiValue!
private let underscoreAscii = Character("_").asciiValue!
private let equalsAscii = Character("=").asciiValue!
private let equalsCharSet = CharacterSet(charactersIn: "=")

public extension Data {
    init?(base64URLEncoded data: Data, options: Data.Base64DecodingOptions = []) {
        var mutableData = data

        // NOTE: we replace chars in the mutable Data
        for (index, char) in mutableData.enumerated() {
            if char == hyphenAscii {
                mutableData[index] = plusAscii
            } else if char == underscoreAscii {
                mutableData[index] = slashAscii
            }
        }

        mutableData.append(Data(repeating: equalsAscii, count: data.count % 4))

        self.init(base64Encoded: mutableData, options: options)
    }

    init?(base64URLEncoded string: String, options: Data.Base64DecodingOptions = []) {
        let padding = String(repeating: "=", count: string.count % 4)

        let convertedString =
            string.replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
                .appending(padding)

        self.init(base64Encoded: convertedString, options: options)
    }

    func base64URLEncodedData(options: Data.Base64EncodingOptions = []) -> Data {
        var data = base64EncodedData(options: options)
        var padding = 0

        // NOTE: we replace chars in the mutable Data
        for (index, char) in data.enumerated() {
            if char == plusAscii {
                data[index] = hyphenAscii
            } else if char == slashAscii {
                data[index] = underscoreAscii
            } else if char == equalsAscii {
                padding += 1
            }
        }

        data.removeLast(padding)

        return data
    }

    func base64URLEncodedString(options: Data.Base64EncodingOptions = []) -> String {
        base64EncodedString(options: options)
            .replacingOccurrences(of: "+", with: "-", options: .literal)
            .replacingOccurrences(of: "/", with: "_", options: .literal)
            .trimmingCharacters(in: equalsCharSet)
    }
}
