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
    // TODO undo force unwraps
    // TODO remove this
    private static let pokemonRange = 1...150
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public func fetchProfile(forSeed seed: String) async -> Result<Profile, FetchError> {
        let profileId = Int.fromSeed(seed, in: Self.pokemonRange)
        
        
        let profileResolver = ProfileResolver(
            // TODO tidy urls
            name: .init(
                url: URL(
                    string: "https://pokeapi.co/api/v2/pokemon-species/\(profileId)"
                )!,
                path: "name"
            ),
            bio: .init(
                url: URL(
                    string: "https://pokeapi.co/api/v2/pokemon-species/\(profileId)"
                )!,
                path: "flavor_text_entries.0.flavor_text"
            ),
            artworkUrl: .init(
                url: URL(
                    string: "https://pokeapi.co/api/v2/pokemon/\(profileId)"
                )!,
                path: "sprites.other.official-artwork.front_default"
            )
        )
        
        do {
            let profile = await DynamicProfile(
                name: try stringValue(fromResolverEntry: profileResolver.name),
                artworkUrl: try URL(string: stringValue(fromResolverEntry: profileResolver.artworkUrl)),
                bio: try stringValue(fromResolverEntry: profileResolver.bio)
            )
            
            return .success(profile)
            
        } catch {
            return .failure(.decodeError)
        }
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

    func decodeJSON(from data: Data) throws -> JSONValue {
        do {
            return try decoder.decode(JSONValue.self, from: data)
        } catch {
            throw FetchError.decodeError
        }
    }

    func stringValue(fromResolverEntry entry: ProfileResolver.Entry) async throws -> String {
        async let data = fetchData(from: entry.url)
        
        return try await decodeJSON(from: data).value(
            at: entry.path
        )?.stringValue ?? ""
    }
    

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
}


struct ProfileResolver {
    let name: Entry
    let bio: Entry
    let artworkUrl: Entry
    
    struct Entry {
        let url: URL
        let path: String
    }
}
