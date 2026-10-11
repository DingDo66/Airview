import Foundation
import UniformTypeIdentifiers

/// 扫描图片所在目录，提供有序的图片列表与当前索引。
public struct ImageFolder {
    public let urls: [URL]
    public var index: Int

    public init(opening url: URL) {
        let dir = url.hasDirectoryPath ? url : url.deletingLastPathComponent()
        let items = (try? FileManager.default.contentsOfDirectory(
            at: dir, includingPropertiesForKeys: [.contentTypeKey],
            options: [.skipsHiddenFiles])) ?? []
        urls = items.filter(ImageFolder.isImage).sorted {
            $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending
        }
        index = urls.firstIndex(of: url) ?? 0
    }

    public var current: URL? { urls.indices.contains(index) ? urls[index] : nil }

    public mutating func next() { if index < urls.count - 1 { index += 1 } }
    public mutating func previous() { if index > 0 { index -= 1 } }

    public static func isImage(_ url: URL) -> Bool {
        guard let type = UTType(filenameExtension: url.pathExtension) else { return false }
        return type.conforms(to: .image)
    }
}
