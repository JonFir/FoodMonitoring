import Foundation
import StandartLib

func urlFactory(rootUrl: String, path: String) throws -> URL {
    try (URL(string: rootUrl)?.appendingPathComponent(path)).value(or: NetworkError.invalidUrl)
}
