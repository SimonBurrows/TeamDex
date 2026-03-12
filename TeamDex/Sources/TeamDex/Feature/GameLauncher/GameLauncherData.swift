//
//  GameLauncherData.swift
//  TeamDex
//
//  Created by Simon Burrows on 12/03/2026.
//

import Foundation

extension GameLauncherView {
    static let exampleGames: [Game] = [
        Game(
            name: "Something ace",
            players:  [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ],
            profileIds: (1...150).map(String.init),
            senarios: [
                Senario(
                    title: "Treasure hunt",
                    text: "Find sombody of the same type as you",
                )
            ],
            sprites: [
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen1.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngn.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen1rb.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen2.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen3.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen3rs.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen4.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen4dp.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen6.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen6xy.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen7.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen8.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen9.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-masters.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster.png",
            ],
            profileResolver: ProfileResolver(
                name: .init(
                    source:
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"
                            ),
                    path: "name"
                ),
                bio: .init(
                    source:
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"
                            ),
                    path: "flavor_text_entries.0.flavor_text"
                ),
                artworkUrl: .init(
                    source:
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon/%@"
                            ),
                    path: "sprites.other.official-artwork.front_default"
                )
            )
        ),
        
        Game(
            name: "Fun game",
            players:  [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ],
            // TODO this is brittle: change this
            profileIds: (0...1).map(String.init),
            senarios: [
                Senario(
                    title: "Sharing what we do",
                    text: "How do we share what we are doing with this user type?"
                ),
                Senario(
                    title: "Hypothesis statement",
                    text: "Can we tun these into a set of hypothesis statements? \nHypothesis statement\nExample: We believe that sharing our roadmap early and often will reduce duplicate efforts and requests from other teams. We will know this is true when duplicate work-streams reduce."
                )
            ],
            sprites: [
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/great-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/ultra-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/premier-ball.png"

            ],
            profileResolver: ProfileResolver(
                name: .init(
                    source: .local(json: personaJson),
                    path: "name"
                ),
                bio: .init(
                    source: .local(json: personaJson),
                    path: "bio"
                ),
                artworkUrl: .init(
                    source: .local(json: personaJson),
                    path: "artworkUrl"
                )
            )
        )
    ]
    
        static let personaJson = """
        [
          {
            "name": "Ash",
            "artworkUrl": "https://play.pokemonshowdown.com/sprites/trainers/ash.png",
            "bio": "I'm a mobile app software engineer..."
          },
          {
            "name": "Misty",
            "artworkUrl": "https://play.pokemonshowdown.com/sprites/trainers/misty.png",
            "bio": "I'm a backend engineer..."
          }
        ]
        """
}

extension GameLauncherView {
    static let exampleGameJson = """
[
        {
            "name": "Something ace",
            "players": [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ],
            "profileIds": [
                "1","2","3","4","5","6","7","8","9","10" // TODO -> 150
            ],
            "senarios": [
                {
                    "title": "Treasure hunt",
                    "text": "Find sombody of the same type as you"
                }
            ],
            "sprites": [
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen1.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngn.png",
                "https://play.pokemonshowdown.com/sprites/trainers/youngster-gen1rb.png"
            ],
            "profileResolver": {
                "name": {
                    "source": {
                        "type": "api",
                        "urlTemplate": "https://pokeapi.co/api/v2/pokemon-species/%@"
                    },
                    "path": "name"
                },
                "bio": {
                    "source": {
                        "type": "api",
                        "urlTemplate": "https://pokeapi.co/api/v2/pokemon-species/%@"
                    },
                    "path": "flavor_text_entries.0.flavor_text"
                },
                "artworkUrl": {
                    "source": {
                        "type": "api",
                        "urlTemplate": "https://pokeapi.co/api/v2/pokemon/%@"
                    },
                    "path": "sprites.other.official-artwork.front_default"
                }
            }
        },
        {
            "name": "Fun game",
            "players": [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ],
            "profileIds": ["0","1"],
            "senarios": [
                {
                    "title": "Sharing what we do",
                    "text": "How do we share what we are doing with this user type?"
                },
                {
                    "title": "Hypothesis statement",
                    "text": "Can we tun these into a set of hypothesis statements?"
                }
            ],
            "sprites": [
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png",
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/great-ball.png"
            ],
            "profileResolver": {
                "name": {
                    "source": {
                        "type": "local",
                        "json": "[{\"name\":\"Ash\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/ash.png\",\"bio\":\"I'm a mobile app software engineer...\"},{\"name\":\"Misty\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/misty.png\",\"bio\":\"I'm a backend engineer...\"}]"
                    },
                    "path": "name"
                },
                "bio": {
                    "source": {
                        "type": "local",
                        "json": "[{\"name\":\"Ash\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/ash.png\",\"bio\":\"I'm a mobile app software engineer...\"},{\"name\":\"Misty\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/misty.png\",\"bio\":\"I'm a backend engineer...\"}]"
                    },
                    "path": "bio"
                },
                "artworkUrl": {
                    "source": {
                        "type": "local",
                        "json": "[{\"name\":\"Ash\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/ash.png\",\"bio\":\"I'm a mobile app software engineer...\"},{\"name\":\"Misty\",\"artworkUrl\":\"https://play.pokemonshowdown.com/sprites/trainers/misty.png\",\"bio\":\"I'm a backend engineer...\"}]"
                    },
                    "path": "artworkUrl"
                }
            }
        }
    ]
"""
}
