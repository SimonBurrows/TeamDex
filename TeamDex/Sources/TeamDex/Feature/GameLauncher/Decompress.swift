//
//  Decompress.swift
//  TeamDexShared
//
//  Created by Simon Burrows on 12/03/2026.
//

import Foundation
import zlib

extension Data {
    func decompressedZlib() throws -> Data {
        guard !isEmpty else { return Data() }

        var stream = z_stream()
        var status: Int32

        status = inflateInit_(
            &stream,
            ZLIB_VERSION,
            Int32(MemoryLayout<z_stream>.size)
        )

        guard status == Z_OK else {
            throw FetchError.decodeError
        }

        defer {
            inflateEnd(&stream)
        }

        return try withUnsafeBytes { rawBuffer in
            guard let baseAddress = rawBuffer.bindMemory(to: Bytef.self).baseAddress else {
                throw FetchError.decodeError
            }

            stream.next_in = UnsafeMutablePointer(mutating: baseAddress)
            stream.avail_in = uInt(count)

            let chunkSize = 16_384
            var output = Data()
            var buffer = [UInt8](repeating: 0, count: chunkSize)

            repeat {
                status = buffer.withUnsafeMutableBufferPointer { bufferPointer in
                    stream.next_out = bufferPointer.baseAddress
                    stream.avail_out = uInt(bufferPointer.count)
                    return inflate(&stream, Z_NO_FLUSH)
                }

                guard status == Z_OK || status == Z_STREAM_END else {
                    throw FetchError.decodeError// TODO change error type
                }

                let bytesWritten = chunkSize - Int(stream.avail_out)
                if bytesWritten > 0 {
                    output.append(buffer, count: bytesWritten)
                }

            } while status != Z_STREAM_END

            if status != Z_STREAM_END {
                throw FetchError.decodeError
            }

            return output
        }
    }
}
