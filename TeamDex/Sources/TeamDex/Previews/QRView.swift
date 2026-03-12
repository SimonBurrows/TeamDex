//
//  QRCard.swift
//  TeamDex
//
//  Created by Simon Burrows on 12/03/2026.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let payload: String

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        VStack(spacing: 16) {
            if let image = makeQRCode(from: payload) {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Text("Failed to generate QR code")
            }

            Text(payload)
                .font(.footnote.monospaced())
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }

    private func makeQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.correctionLevel = "M"

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scaledImage = outputImage.transformed(
            by: CGAffineTransform(scaleX: 12, y: 12)
        )

        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    QRCodeView(
        payload: ExampleQRCodes.pokemonIcebreaker
    )
}

enum ExampleQRCodes {
    static let pokemonIcebreaker = "eNq1ls9u4zYQxl+FENBbYouSLEu5tIdFCxc9FN30tCgCWqIsITIpkFS8RpAH6nP0xTrfUJs/QE+teqBGoeY3M9R8Gfk5Meqsk7vkV/v4159na8Sh0Uen1aN24ic8ukmmUV2188ndl+Rn1TzSDoy3Jt7ZI9uz9tEOmq3TLdtvfn7Sjm+u8dpq3tcqmq5jY4xa7NBFf+30+RpvXLTe68UODXsP4whj+aKWELbR45VjWx2v0ak3izEcLVZnXRvrsF5PfbzpZ5X8Qad3thtGfWj5BUh6ltHKaRW0drRKWntaFa2alkxxgaeEq4SvhLOEt4S7hL8EIEFkIDKODSIDkYHIQGQgMhAZiAxEDiIHkXM5IHIQOYgcRA4iB5GDKEAUIAoQBZ8ARAGiAFGAKEAUIHYgdiB2IHYgdnxoEDsQOxA7EDsQJYgSRAmiBFGCKPk9gShBlCBKEHsQexB7EHsQexB7EHt+tSD2IPYgKhAViApEBaICUYGoQFTcDRAViBpEDaIGUYOoQdQgahA1iJobGDvILUy5hyk3MeUuptzGlPuYciNT7mTKrUyZXdrPbBRAVECUQNRAFEFUQZQB60CyEGQWtcMsa0GyGCSrQbIcJOtBsiAkK0KyJCRrQuZReMyyLCTrQrIwJCtDsjQka0OyOCSrQ7I8ZBFVyywrRLJEJGtEskgkq0SSTOjfxGuj3GDxT/KchCGMGCr3Fyvu3Rx6L5RphRK/8HAI+mugp597GhIikE9487FGi3HQQh3tHMTVzs7rsduI+16Lk7PzJE4zJoAXoWfPTfJy85bxR/VEyBC0+DbQ3vIdOsQTF5ooVMrrwAtODUa7G3Hph6Z/27/YeWzFUXMRYlIukBfXeOmv33/I+nnSuhUHE5xt5yYM1vh3aZdt/XoaDuL59DjubGY/q1H09ni8CuvEYALV6MPHo32iqXwWn2eao5O98HD8eLCGC+7VEx3PXIV/9cTRVFgONAScCRX09rLsgZ69pmcfz/VJe+2COPgR/oegz//8Nj29Q9NqdI/ebBupgakltx/MaUQCfX6X8+hom1JCPxO6xjO2D2Hyd9stvjubyT5q6oanYlt7MZvGnreL73bpnN9SLHPy9NJuT9rIzWROVOe/DGP+G/5ahTuuEyhbJ0y+Uhjn1wlUrBSmndYJVK4U5ut1nUD7dcJU64SpVwhzVjAryIcjvP0y+017Oz7RPLx7Xn7MPieeJm3Dd+E6YZKpaaCksxvv9ZlSBuy9lkDZ6Tll3ZLZPmXbpZ5b+s3aDFTDdz/QWEwmFXrCOAf9eRzs/52qG+lz5h4wcR80fUbIYZNu3u3Clz5MF+sef3fjeuV8LGNpxcbSJ9dtbNcNzaDG2yXxpnPWhIdWd2oeqaKXl78BbdHcaA=="
}
