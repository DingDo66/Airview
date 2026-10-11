import AppKit
import AirviewCore

/// 单图查看：缩放、平移、键盘翻页。
public final class ViewerController: NSViewController {
    private var folder: ImageFolder
    private let scrollView = NSScrollView()
    private let imageView = NSImageView()

    public init(url: URL) {
        folder = ImageFolder(opening: url)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    public override func loadView() {
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.allowsMagnification = true
        scrollView.minMagnification = 0.05
        scrollView.maxMagnification = 32
        scrollView.backgroundColor = .black
        imageView.imageScaling = .scaleProportionallyUpOrDown
        scrollView.documentView = imageView
        view = scrollView
    }

    public override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.makeFirstResponder(self)
        show()
    }

    private func show() {
        guard let url = folder.current, let img = ImageLoader.shared.image(at: url) else { return }
        imageView.image = img
        imageView.frame = NSRect(origin: .zero, size: img.size)
        view.window?.title = url.lastPathComponent
        fit()
        let i = folder.index, u = folder.urls
        ImageLoader.shared.preload([i - 1, i + 1].filter(u.indices.contains).map { u[$0] })
    }

    private func fit() {
        guard let size = imageView.image?.size, size.width > 0 else { return }
        let bounds = scrollView.contentSize
        scrollView.magnification = min(bounds.width / size.width, bounds.height / size.height, 1)
    }

    public override var acceptsFirstResponder: Bool { true }

    public override func keyDown(with event: NSEvent) {
        switch event.charactersIgnoringModifiers {
        case "=", "+": scrollView.magnification *= 1.25
        case "-": scrollView.magnification /= 1.25
        case "0": fit()
        case "1": scrollView.magnification = 1
        default:
            switch event.keyCode {
            case 123, 126: folder.previous(); show()
            case 124, 125: folder.next(); show()
            default: super.keyDown(with: event)
            }
        }
    }
}
