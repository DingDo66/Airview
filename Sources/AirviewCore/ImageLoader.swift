import AppKit
import ImageIO

/// 基于 ImageIO 的解码与缓存。
public final class ImageLoader {
    public static let shared = ImageLoader()
    private let cache = NSCache<NSURL, NSImage>()

    public init() { cache.countLimit = 12 }

    public func image(at url: URL) -> NSImage? {
        if let hit = cache.object(forKey: url as NSURL) { return hit }
        guard let src = CGImageSourceCreateWithURL(url as CFURL, nil),
              let cg = CGImageSourceCreateImageAtIndex(src, 0, [kCGImageSourceShouldCacheImmediately: true] as CFDictionary)
        else { return nil }
        let img = NSImage(cgImage: cg, size: NSSize(width: cg.width, height: cg.height))
        cache.setObject(img, forKey: url as NSURL)
        return img
    }

    /// 后台预加载相邻图片。
    public func preload(_ urls: [URL]) {
        DispatchQueue.global(qos: .utility).async { urls.forEach { _ = self.image(at: $0) } }
    }

    public func thumbnail(at url: URL, maxPixel: Int = 160) -> NSImage? {
        guard let src = CGImageSourceCreateWithURL(url as CFURL, nil) else { return nil }
        let opts: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ]
        guard let cg = CGImageSourceCreateThumbnailAtIndex(src, 0, opts as CFDictionary) else { return nil }
        return NSImage(cgImage: cg, size: .zero)
    }
}
