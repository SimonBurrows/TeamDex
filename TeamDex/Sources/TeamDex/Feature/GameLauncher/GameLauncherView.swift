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
    @State private var games: [Game]
    @State private var showingScanner = false
    @State private var scanError: String?
    @State private var scannedGame: Game?

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        showingScanner = true
                    } label: {
                        Label("Load Game from QR Code", systemImage: "qrcode.viewfinder")
                    }
                }

                Section("Example Games") {
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
//                            let game = try JSONDecoder().decode(
//                                Game.self,
//                                from: Data(qrString.utf8)
//                            )
                            
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
    
    

    // TODO get this out of view
    public init() {
        do {
            let data = Data(Self.exampleGameJson.utf8)
            _games = State(initialValue: try JSONDecoder().decode([Game].self, from: data))
        } catch {
            print("Failed to decode games:", error)
            _games = State(initialValue: [])
        }
    }
    
    func decodeGame(from scanned: String) throws -> Game {
        guard let compressed = Data(base64Encoded: scanned) else {
            throw FetchError.decodeError
        }

        let jsonData = try compressed.decompressedZlib()
        return try JSONDecoder().decode(Game.self, from: jsonData)
    }
}

#Preview {
    GameLauncherView()
}
