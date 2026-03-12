//
//  Decompress.swift
//  TeamDexShared
//
//  Created by Simon Burrows on 12/03/2026.
//

import Foundation
import Compression

extension Data {
    func decompressedZlib() throws -> Data {
        let destinationBufferSize = 64 * 1024

        return try withUnsafeBytes { sourceBuffer in
            guard let sourcePointer = sourceBuffer.bindMemory(to: UInt8.self).baseAddress else {
                throw FetchError.decodeError
            }

            var output = Data()
            var sourceSize = count
            var sourceOffset = 0

            repeat {
                var destinationBuffer = [UInt8](repeating: 0, count: destinationBufferSize)

                let decodedSize = compression_decode_buffer(
                    &destinationBuffer,
                    destinationBufferSize,
                    sourcePointer.advanced(by: sourceOffset),
                    sourceSize,
                    nil,
                    COMPRESSION_ZLIB
                )

                guard decodedSize > 0 else {
                    throw FetchError.decodeError
                }

                output.append(destinationBuffer, count: decodedSize)

                sourceOffset += sourceSize
                sourceSize = 0
            } while false

            return output
        }
    }
}
