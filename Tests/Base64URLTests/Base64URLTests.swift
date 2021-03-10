import XCTest
@testable import Base64URL

final class Base64Tests: XCTestCase {
    // See https://tools.ietf.org/html/rfc4648#section-10
    func testRFCTestVectorsAndSpecialURLSafeCases() throws {
        let vectors = [
            "": "",
            "f": "Zg",
            "fo": "Zm8",
            "foo": "Zm9v",
            "foob": "Zm9vYg",
            "fooba": "Zm9vYmE",
            "foobar": "Zm9vYmFy",
            "😟": "8J-Ynw",
            "⦿": "4qa_"
        ]

        try vectors.forEach { (expectedString, expectedEncodedString) throws in
            let expectedEncodedData = Data(expectedEncodedString.utf8)
            let expectedData = Data(expectedString.utf8)

            let encodedString = expectedData.base64URLEncodedString()
            let encodedData = expectedData.base64URLEncodedData()


            let decodedDataFromString = try XCTUnwrap(Data(base64URLEncoded: expectedEncodedString))

            let decodedDataFromData = try XCTUnwrap(Data(base64URLEncoded: expectedEncodedData))

            XCTAssertEqual(encodedString, expectedEncodedString)
            XCTAssertEqual(decodedDataFromString, expectedData)
            XCTAssertEqual(decodedDataFromData, expectedData)
            XCTAssertEqual(encodedData, expectedEncodedData)
        }
    }
}
