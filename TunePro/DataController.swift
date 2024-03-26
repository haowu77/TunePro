
import SwiftUI

class DataController: ObservableObject {
    // 使用 @AppStorage 存储应用程序数据的属性
    @AppStorage("currentTheme") var currentTheme = Theme.original.name // 当前主题
    @AppStorage("currentSymbol") var currentSymbol = Tuner.Symbol.sharp.rawValue // 当前音调符号
    @AppStorage("visualizerIsShowing") var visualizerIsShowing = true // 是否显示可视化器
    @AppStorage("isFirstAppRun") var isFirstAppRun = true // 是否是第一次运行应用程序
    @AppStorage("appRunCount") var appRunCount = 0 // 应用程序运行次数统计

    // 用于在整个应用程序中反映主题更改的 @Published 属性
    @Published var theme = Theme.original {
        didSet {
            // 当主题更改时，将当前主题存储在用户偏好设置中
            currentTheme = theme.name
        }
    }

    // DataController 的单例实例
    static var sharedInstance: DataController = {
        let data = DataController()
        // 从用户偏好设置中检索当前主题并设置它
        data.theme = Theme.with(name: data.currentTheme)
        
        return data
    }()

    // 用于增加应用程序运行次数的私有初始化方法
    private init() {
        appRunCount += 1
    }

    // 用于循环遍历可用主题的方法
    func nextTheme() {
        theme = theme.next()
    }
}

// 表示应用程序主题的结构体
struct Theme: Equatable {
    // 所有可用主题的数组
    private static let themes: [Theme] = [Theme.original, Theme.retro]

    // 主题属性
    var name: String // 名称
    var accentColor: Color // 强调色
    var backgroundColor: Color // 背景色
    var sharpColor: Color // 升号音调颜色
    var flatColor: Color // 降号音调颜色
    var tunedColor: Color // 调音颜色
    var visualizerColor: Color // 可视化器颜色
    var faceColor: Color // 表面颜色

    // 获取数组中下一个主题的方法
    fileprivate func next() -> Theme {
        Theme.themes.item(afterWithWrapAround: self) ?? Theme.original
    }

    // 通过名称获取主题的方法
    fileprivate static func with(name: String) -> Theme {
        Theme.themes.first(where: { theme in
            theme.name == name
        }) ?? Theme.original
    }
}

// Theme 结构体的扩展，用于定义主题预设
extension Theme {
    // 在这里定义主题预设

    // 原始主题预设
    fileprivate static let original = Theme(
        name: "默认",
        accentColor: Color.white,
        backgroundColor: Color.black,
        sharpColor: Color.yellow,
        flatColor: Color.red,
        tunedColor: Color.green,
        visualizerColor: Color.pink,
        faceColor: Color(.systemGray6)
    )

    // 复古主题预设
    fileprivate static let retro = Theme(
        name: "复古",
        accentColor: Color.black,
        backgroundColor: Color("Pitch"),
        sharpColor: Color("Babouche"),
        flatColor: Color("Charlotte"),
        tunedColor: Color("Emerald"),
        visualizerColor: Color("Wevet"),
        faceColor: Color("Tar")
    )
}
