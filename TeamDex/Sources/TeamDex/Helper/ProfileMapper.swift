//
//  ProfileMapper.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

// AI generated
import Foundation

public enum JSONValue: Sendable, Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([JSONValue])
    case object([String: JSONValue])
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([JSONValue].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: JSONValue].self) {
            self = .object(value)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported JSON value"
            )
        }
    }
}

public extension JSONValue {
    var stringValue: String? {
        if case .string(let value) = self { return value }
        return nil
    }

    var intValue: Int? {
        if case .int(let value) = self { return value }
        return nil
    }

    var doubleValue: Double? {
        if case .double(let value) = self { return value }
        return nil
    }

    var boolValue: Bool? {
        if case .bool(let value) = self { return value }
        return nil
    }

    var arrayValue: [JSONValue]? {
        if case .array(let value) = self { return value }
        return nil
    }

    var objectValue: [String: JSONValue]? {
        if case .object(let value) = self { return value }
        return nil
    }

    func value(at path: String) -> JSONValue? {
        let parts = path.split(separator: ".").map(String.init)
        return value(at: parts)
    }

    private func value(at parts: [String]) -> JSONValue? {
        guard let first = parts.first else { return self }

        let remaining = Array(parts.dropFirst())

        switch self {
        case .object(let object):
            guard let next = object[first] else { return nil }
            return next.value(at: remaining)

        case .array(let array):
            guard let index = Int(first), array.indices.contains(index) else { return nil }
            return array[index].value(at: remaining)

        default:
            return nil
        }
    }
}

// TODO why is this needed
public struct DynamicProfile: Profile, Sendable, Hashable, Codable {
    public let name: String
    public let artworkUrl: URL?
    public let bio: String

    public init(name: String, artworkUrl: URL?, bio: String) {
        self.name = name
        self.artworkUrl = artworkUrl
        self.bio = bio
    }
}

public struct ProfileMapper: Sendable {
    public typealias Resolver = @Sendable (JSONValue) -> String?
    public typealias URLResolver = @Sendable (JSONValue) -> URL?

    private let nameResolver: Resolver
    private let artworkResolver: URLResolver
    private let bioResolver: Resolver

    public init(
        name: @escaping Resolver,
        artworkUrl: @escaping URLResolver,
        bio: @escaping Resolver
    ) {
        self.nameResolver = name
        self.artworkResolver = artworkUrl
        self.bioResolver = bio
    }

    public func map(_ json: JSONValue) -> DynamicProfile {
        DynamicProfile(
            name: nameResolver(json) ?? "Unknown",
            artworkUrl: artworkResolver(json),
            bio: bioResolver(json)?
                .replacingOccurrences(of: "\n", with: " ")
//                .replacingOccurrences(of: "\u{000C}", with: " ")
                ?? ""
        )
    }
}

public extension ProfileMapper {
    static func pathBased(
        namePath: String,
        artworkUrlPath: String?,
        bioPath: String
    ) -> ProfileMapper {
        ProfileMapper(
            name: { json in
                json.value(at: namePath)?.stringValue
            },
            artworkUrl: { json in
                print("artwork Path: \(artworkUrlPath)")
                guard
                    let artworkUrlPath,
                    let string = json.value(at: artworkUrlPath)?.stringValue
                else { return nil }
                
                print("artwork String: \(string)")

                return URL(string: string)
            },
            bio: { json in
                json.value(at: bioPath)?.stringValue
            }
        )
    }
}

// TODO remove pokemon bit
public extension ProfileMapper {
    static let pokemon = ProfileMapper(
        name: { json in
            json.value(at: "name")?.stringValue?.capitalized
        },
        artworkUrl: { json in
            guard let id = json.value(at: "id")?.intValue else { return nil }
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
        },
        bio: { json in
            json.value(at: "flavor_text_entries.0.flavor_text")?.stringValue
        }
    )
}
