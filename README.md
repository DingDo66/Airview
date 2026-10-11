# Airview

原生、秒开、不打扰的 macOS 开源看图工具。

- Swift + AppKit，纯原生
- 免费、开源（MIT），不追踪任何用户数据
- 键盘优先：方向键翻页、`+`/`-` 缩放、`0` 适应窗口

## 构建

需要 macOS 13+ 与 Xcode 15+（Swift 5.9）。

```bash
git clone https://github.com/DingDo66/Airview.git
cd Airview
swift build
swift run Airview /path/to/image.jpg
```

## 模块

| 模块 | 职责 |
| --- | --- |
| `AirviewCore` | 图片解码（ImageIO）、目录扫描、缓存与预加载 |
| `AirviewViewer` | 单图视图：缩放、平移、翻页、缩略图栏 |
| `AirviewGrid` | 网格浏览（v0.5） |
| `AirviewPin` | 钉图悬浮窗（v1.0） |
| `AirviewApp` | 应用入口、菜单、窗口管理 |

## 路线图

见 [ROADMAP.md](ROADMAP.md)。

## 分发

GitHub Releases 与 Homebrew Cask（计划中）。

## 协议

MIT，见 [LICENSE](LICENSE)。
