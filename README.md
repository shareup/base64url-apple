# Base64URL package for Apple platforms

`Base64URL` provides extensions to `Data` for encoding and decoding bytes to and from `base64url` encoding. Padding is optional for `base64url` encoded strings and this package always omits `=` padding. 

See the [variants summary table][] of the Wikipedia page for [Base64][] and [section 5 of RFC 4648][] for the specifics.

[variants summary table]: https://en.wikipedia.org/wiki/Base64#Variants_summary_table
[Base64]: https://en.wikipedia.org/wiki/Base64
[section 5 of RFC 4648]: https://tools.ietf.org/html/rfc4648#section-5

## Usage

## Installation

To use `Base64URL` with the Swift Package Manager, add the dependency to your `Package.swift` file:

```swift
let package = Package(
   dependencies: [
       .package(
           name: "Base64URL", 
           url: "https://github.com/shareup/base64url-apple.git", 
           from: "0.0.0"
       )
   ]
)
```
