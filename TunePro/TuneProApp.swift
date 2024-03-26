
import AVFoundation
import SwiftUI

@main
struct TuneProApp: App {
    // 创建一个 DataController 的实例，用于管理应用程序的数据
    @ObservedObject var data = DataController.sharedInstance

    // 创建一个 AudioController 的实例，用于管理音频播放
    let audio = AudioController.sharedInstance

    // 初始化方法
    init() {
        // 在调试模式下禁用动画
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            UIView.setAnimationsEnabled(false)
        }
        #endif
    }

    var body: some Scene {
        // 定义应用程序的主窗口
        WindowGroup {
            // 根据应用程序是否为第一次运行来选择显示不同的视图
            if data.isFirstAppRun {
                // 如果是第一次运行，显示新手引导页面
                OnboardingView() { newValue in
                    // 当新手引导完成后，更新 isFirstAppRun 属性
                    data.isFirstAppRun = newValue
                    
                    // 然后延迟 3 秒后将 isFirstAppRun 设置为 true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                data.isFirstAppRun = true
                            }
                }
            } else {
                // 如果不是第一次运行，显示根视图
                RootView()
                    // 将 DataController 对象传递给子视图
                    .environmentObject(data)
                    // 设置首选的颜色主题为暗色模式
                    .preferredColorScheme(.dark)
                    // 监听音频会话路由变化通知，执行相应的处理方法
                    .onReceive(
                        NotificationCenter.default.publisher(for: AVAudioSession.routeChangeNotification),
                        perform: audio.handleRouteChange)
                    // 监听应用程序即将失去活跃状态的通知，执行相应的处理方法
                    .onReceive(
                        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                        perform: audio.pause)
                    // 监听应用程序重新变为活跃状态的通知，执行相应的处理方法
                    .onReceive(
                        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification),
                        perform: audio.resume)
                    // 监听音频会话中断通知，执行相应的处理方法
                    .onReceive(
                        NotificationCenter.default.publisher(for: AVAudioSession.interruptionNotification),
                        perform: audio.handleInterruption)
            }
        }
    }
}
