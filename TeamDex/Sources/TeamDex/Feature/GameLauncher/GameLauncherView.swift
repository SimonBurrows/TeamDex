//
//  GameLauncherView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI
import VisionKit

// TODO break this up
public struct GameLauncherView: View {
    @State private var games: [Game] = []
    @State private var showingScanner = false
    @State private var scanError: String?
    @State private var scannedGame: Game?

    public var body: some View {
        NavigationStack {
            List {
                Section("Example Games") {
                    ForEach(Self.exampleGames, id: \.name) { game in
                        NavigationLink {
                            MenuListView(
                                players: game.players,
                                profileResolver: game.profileResolver,
                                profileIds: game.profileIds,
                                senarios: game.senarios,
                                sprites: game.sprites
                            )
                        } label: {
                            Text(game.name)
                        }
                    }
                }
                
                Section {
                    Button {
                        showingScanner = true
                    } label: {
                        Label("Load Game from QR Code", systemImage: "qrcode.viewfinder")
                    }
                }

                Section("Installed Games") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink {
                            MenuListView(
                                players: game.players,
                                profileResolver: game.profileResolver,
                                profileIds: game.profileIds,
                                senarios: game.senarios,
                                sprites: game.sprites
                            )
                        } label: {
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Select Game")
            .sheet(isPresented: $showingScanner) {
                QRCodeScannerView { result in
                    showingScanner = false

                    switch result {
                    case .success(let qrString):
                        do {
                            let game = try decodeGame(from: qrString)
                            
                            games.append(game)
                        } catch {
                            scanError = "That QR code didn't contain a valid game JSON payload."
                        }

                    case .failure(let error):
                        scanError = error.localizedDescription
                    }
                }
            }
            .alert("Couldn’t Load Game", isPresented: .constant(scanError != nil)) {
                Button("OK") { scanError = nil }
            } message: {
                Text(scanError ?? "")
            }
        }
    }
    
    func decodeGame(from scanned: String) throws -> Game {
       
        let cleaned = scanned.trimmingCharacters(in: .whitespacesAndNewlines)
        

        guard let compressedData = Data(base64Encoded: cleaned) else {
            print("Base64 decode failed")
            print("Prefix:", cleaned.prefix(80))
            print("Length:", cleaned.count)
            throw FetchError.decodeError
        }

        print("Compressed bytes:", compressedData.count)

        let jsonData = try compressedData.decompressedZlib()
        print("JSON bytes:", jsonData.count)

        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("UTF-8 conversion failed")
            throw FetchError.decodeError
        }

        print("Decoded JSON string:", jsonString)

        do {
            return try JSONDecoder().decode(Game.self, from: jsonData)
        } catch {
            print("Game decode failed:", error)
            throw error
        }
    }
}

#Preview {
    GameLauncherView()
}


extension GameLauncherView {
    private static let exampleData  = "eNq1ls9u4zYQxl+FENBbYouSLEu5tIdFCxc9FN30tCgCWqIsITIpkFS8RpAH6nP0xTrfUJs/QE+teqBGoeY3M9R8Gfk5Meqsk7vkV/v4159na8Sh0Uen1aN24ic8ukmmUV2188ndl+Rn1TzSDoy3Jt7ZI9uz9tEOmq3TLdtvfn7Sjm+u8dpq3tcqmq5jY4xa7NBFf+30+RpvXLTe68UODXsP4whj+aKWELbR45VjWx2v0ak3izEcLVZnXRvrsF5PfbzpZ5X8Qad3thtGfWj5BUh6ltHKaRW0drRKWntaFa2alkxxgaeEq4SvhLOEt4S7hL8EIEFkIDKODSIDkYHIQGQgMhAZiAxEDiIHkXM5IHIQOYgcRA4iB5GDKEAUIAoQBZ8ARAGiAFGAKEAUIHYgdiB2IHYgdnxoEDsQOxA7EDsQJYgSRAmiBFGCKPk9gShBlCBKEHsQexB7EHsQexB7EHt+tSD2IPYgKhAViApEBaICUYGoQFTcDRAViBpEDaIGUYOoQdQgahA1iJobGDvILUy5hyk3MeUuptzGlPuYciNT7mTKrUyZXdrPbBRAVECUQNRAFEFUQZQB60CyEGQWtcMsa0GyGCSrQbIcJOtBsiAkK0KyJCRrQuZReMyyLCTrQrIwJCtDsjQka0OyOCSrQ7I8ZBFVyywrRLJEJGtEskgkq0SSTOjfxGuj3GDxT/KchCGMGCr3Fyvu3Rx6L5RphRK/8HAI+mugp597GhIikE9487FGi3HQQh3tHMTVzs7rsduI+16Lk7PzJE4zJoAXoWfPTfJy85bxR/VEyBC0+DbQ3vIdOsQTF5ooVMrrwAtODUa7G3Hph6Z/27/YeWzFUXMRYlIukBfXeOmv33/I+nnSuhUHE5xt5yYM1vh3aZdt/XoaDuL59DjubGY/q1H09ni8CuvEYALV6MPHo32iqXwWn2eao5O98HD8eLCGC+7VEx3PXIV/9cTRVFgONAScCRX09rLsgZ69pmcfz/VJe+2COPgR/oegz//8Nj29Q9NqdI/ebBupgakltx/MaUQCfX6X8+hom1JCPxO6xjO2D2Hyd9stvjubyT5q6oanYlt7MZvGnreL73bpnN9SLHPy9NJuT9rIzWROVOe/DGP+G/5ahTuuEyhbJ0y+Uhjn1wlUrBSmndYJVK4U5ut1nUD7dcJU64SpVwhzVjAryIcjvP0y+017Oz7RPLx7Xn7MPieeJm3Dd+E6YZKpaaCksxvv9ZlSBuy9lkDZ6Tll3ZLZPmXbpZ5b+s3aDFTDdz/QWEwmFXrCOAf9eRzs/52qG+lz5h4wcR80fUbIYZNu3u3Clz5MF+sef3fjeuV8LGNpxcbSJ9dtbNcNzaDG2yXxpnPWhIdWd2oeqaKXl78BbdHcaA=="
}
