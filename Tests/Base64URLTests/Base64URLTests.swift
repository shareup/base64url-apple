@testable import Base64URL
import XCTest

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
            "⦿": "4qa_",
        ]

        try vectors.forEach { expectedString, expectedEncodedString throws in
            let expectedEncodedData = Data(expectedEncodedString.utf8)
            let expectedData = Data(expectedString.utf8)

            let encodedString = expectedData.base64URLEncodedString()
            let encodedData = expectedData.base64URLEncodedData()

            let decodedDataFromString =
                try XCTUnwrap(Data(base64URLEncoded: expectedEncodedString))

            let decodedDataFromData = try XCTUnwrap(Data(base64URLEncoded: expectedEncodedData))

            XCTAssertEqual(encodedString, expectedEncodedString)
            XCTAssertEqual(decodedDataFromString, expectedData)
            XCTAssertEqual(decodedDataFromData, expectedData)
            XCTAssertEqual(encodedData, expectedEncodedData)
        }
    }

    func testWithUUIDBytes() throws {
        let uuid = try XCTUnwrap(UUID(uuidString: "67f266af-a882-4949-b7f6-52e1f3edc08d"))
        let u = uuid.uuid
        let data = Data([
            u.0, u.1, u.2, u.3,
            u.4, u.5, u.6, u.7,
            u.8, u.9, u.10, u.11,
            u.12, u.13, u.14, u.15,
        ])

        XCTAssertEqual("Z/Jmr6iCSUm39lLh8+3AjQ==", data.base64EncodedString())
        XCTAssertEqual("Z_Jmr6iCSUm39lLh8-3AjQ", data.base64URLEncodedString())

        let decoded = try XCTUnwrap(Data(base64URLEncoded: "Z_Jmr6iCSUm39lLh8-3AjQ"))
        var bytes: uuid_t = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        decoded.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) in
            bytes.0 = ptr[0]; bytes.1 = ptr[1]; bytes.2 = ptr[2]; bytes.3 = ptr[3]
            bytes.4 = ptr[4]; bytes.5 = ptr[5]; bytes.6 = ptr[6]; bytes.7 = ptr[7]
            bytes.8 = ptr[8]; bytes.9 = ptr[9]; bytes.10 = ptr[10]; bytes.11 = ptr[11]
            bytes.12 = ptr[12]; bytes.13 = ptr[13]; bytes.14 = ptr[14]; bytes.15 = ptr[15]
        }
        let decodedUUID = UUID(uuid: bytes)
        XCTAssertEqual(uuid, decodedUUID)
    }
}
