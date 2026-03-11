//
//  ProfileFetcher.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import Foundation

struct ProfileFetcher: ProfileFetcherProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let profileResolver: ProfileResolver
    
    public func fetchProfile(withId profileId: String) async -> Result<any Profile, FetchError> {
        do {
            let profile = await DynamicProfile(
                name: try stringValue(fromResolverEntry: profileResolver.name, profileId: profileId),
                artworkUrl: try URL(string: stringValue(fromResolverEntry: profileResolver.artworkUrl, profileId: profileId)),
                bio: try stringValue(fromResolverEntry: profileResolver.bio, profileId: profileId)
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

    func stringValue(fromResolverEntry entry: ProfileResolver.Entry, profileId: String) async throws -> String {
        switch entry.source {
        case .local(data: let data):
            return try decodeJSON(from: data).value(
                // TODO tidy up logic here!
                // Note, - is hardcoded but needs to be passed in
                at: "\(profileId).\(entry.path)"
            )?.stringValue ?? ""
        case .api(urlTemplate: let urlTemplate):
            guard let url = URL(string: String(format: urlTemplate, profileId)) else {
                throw FetchError.urlError
            }
            async let data = fetchData(from: url)
            
            return try await decodeJSON(from: data).value(
                at: entry.path
            )?.stringValue ?? ""
        }
    }
    

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        profileResolver: ProfileResolver
    ) {
        self.session = session
        self.decoder = decoder
        self.profileResolver = profileResolver
    }
}


public struct ProfileResolver: Sendable {
    let name: Entry
    let bio: Entry
    let artworkUrl: Entry
    
    struct Entry {
        let source: Source
        let path: String
    }
    
    enum Source {
        case local(data: Data)
        case api(urlTemplate: String)
    }
}
