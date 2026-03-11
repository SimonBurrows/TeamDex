//
//  ProfileFetcher.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import Foundation

protocol ProfileFetcherProtocol: Sendable {
    func fetchProfile(forSeed seed: String) async -> Result<Profile, FetchError>
}


struct ProfileFetcher: ProfileFetcherProtocol {
    // TODO remove this
    private static let pokemonRange = 1...150
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public func fetchProfile(forSeed seed: String) async -> Result<Profile, FetchError> {
        let profileId = Int.fromSeed(seed, in: Self.pokemonRange)
        
        
        let profileEntries = ProfileEntries(
            // TODO tidy urls
            name: Entry(
                urlString: "https://pokeapi.co/api/v2/pokemon-species/\(profileId)",
                path: "name"),
            bio: Entry(
                urlString: "https://pokeapi.co/api/v2/pokemon-species/\(profileId)",
                path: "flavor_text_entries.0.flavor_text"),
            artworkUrl: Entry(
                urlString: "https://pokeapi.co/api/v2/pokemon/\(profileId)",
                path: "sprites.other.official-artwork.front_default")
        )
        
        
        guard let nameUrl = URL(string: profileEntries.name.urlString) else {
            return .failure(.urlError)
        }
        
        guard let bioUrl = URL(string: profileEntries.bio.urlString) else {
            return .failure(.urlError)
        }
        
        guard let artworkUrlUrl = URL(string: profileEntries.artworkUrl.urlString) else {
            return .failure(.urlError)
        }
        
        guard let (dataForName, _) = try? await URLSession.shared.data(from: nameUrl) else {
            return .failure(.decodeError)
        }
        
        guard let (dataForBio, _) = try? await URLSession.shared.data(from: bioUrl) else {
            return .failure(.decodeError)
        }
        
        guard let (dataForArtworkUrl, _) = try? await URLSession.shared.data(from: artworkUrlUrl) else {
            return .failure(.decodeError)
        }
        
        let jsonForName = try? decoder.decode(JSONValue.self, from: dataForName)
        let name = jsonForName?.value(at: profileEntries.name.path)!.stringValue
        
        let jsonForBio = try? decoder.decode(JSONValue.self, from: dataForBio)
        let bio = jsonForBio?.value(at: profileEntries.bio.path)!.stringValue
        
        let jsonForArtworkUrl = try? decoder.decode(JSONValue.self, from: dataForArtworkUrl)
        let artworkUrlString = jsonForArtworkUrl?.value(at: profileEntries.artworkUrl.path)?.stringValue
        let artworkUrl = URL(string: artworkUrlString ?? "")
        
        // TODO tidy force unwaraps in this file
        let profile = DynamicProfile(name: name!, artworkUrl: artworkUrl, bio: bio!)
        
        return .success(profile)
    }
    
    
    // TODO error handling
    func loadProfile(from data: Data, mapper: ProfileMapper) throws -> DynamicProfile {
        let json = try JSONDecoder().decode(JSONValue.self, from: data)
        return mapper.map(json)
    }
    
    func loadString(from data: Data, path: String) throws -> String? {
        let json = try JSONDecoder().decode(JSONValue.self, from: data)
        return json.value(at: path)?.stringValue
    }
    
    func fetchData(from url: URL) async throws -> Data {
            do {
                let (data, response) = try await session.data(from: url)

                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw FetchError.decodeError
                }

                return data
            } catch {
                throw FetchError.decodeError
            }
        }

    

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
}

// TODO rename
fileprivate struct Entry {
    let urlString: String
    let path: String
}

fileprivate struct ProfileEntries{
    let name: Entry
    let bio: Entry
    let artworkUrl: Entry
}
