import Foundation

let plusChar = Character("+").asciiValue!
let slashChar = Character("/").asciiValue!
let hyphenChar = Character("-").asciiValue!
let underscoreChar = Character("_").asciiValue!
let equalsChar = Character("=").asciiValue!

public extension Data {
    init?(base64URLEncoded data: Data, options: Data.Base64DecodingOptions = []) {
        var mutableData = data

        // NOTE: we replace chars in the mutable Data
        for (index, char) in mutableData.enumerated() {
            if char == hyphenChar {
                mutableData[index] = plusChar
            } else if char == underscoreChar {
                mutableData[index] = slashChar
            }
        }

        mutableData.append(Data(repeating: equalsChar, count: data.count % 4))

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
            if char == plusChar {
                data[index] = hyphenChar
            } else if char == slashChar {
                data[index] = underscoreChar
            } else if char == equalsChar {
                padding += 1
            }
        }

        data.removeLast(padding)

        return data
    }

    func base64URLEncodedString(options: Data.Base64EncodingOptions = []) -> String {
        base64EncodedString(options: options)
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .trimmingCharacters(in: CharacterSet(charactersIn: "="))
    }
}
