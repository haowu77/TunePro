
import SwiftUI
import PageView

// 定义了一个用于显示应用程序介绍页面的视图
struct OnboardingView: View {
    let isFirstRun: (Bool) -> Void // 用于标记是否是第一次运行应用程序的闭包

    var body: some View {
        PageView { // 使用PageView来展示多个页面的内容
            pageOne // 第一页
            pageTwo // 第二页
        }
        .font(.system(size: UIDevice.isPad ? 30 : 15, design: .monospaced)) // 设置字体大小和设计
    }

    // 第一页的视图
    var pageOne: some View {
        VStack { // 垂直布局
            TuningForkShape() // 自定义形状，调音叉的图形
                .scaledToFit() // 按比例缩放以适应容器
                .frame(height: UIDevice.isPad ? 400 : 200) // 设置高度
                .padding(.bottom, 50) // 底部留白
            Text("thanks for choosing") // 文本：“谢谢选择”
                .padding(.bottom, 1) // 底部留白
            Text("TunePro!") // 文本：“TunePro！”
                .padding(.bottom, 30) // 底部留白
        }
        .font(.system(size: UIDevice.isPad ? 40 : 20, design: .monospaced)) // 设置字体大小和设计
    }

    // 第二页的视图
    var pageTwo: some View {
        VStack(alignment: .center) { // 垂直布局，内容居中对齐
            Text("getting started") // 文本：“开始入门”
                .fontWeight(.semibold) // 设置字体粗细
                .padding(.top, 40) // 顶部留白
                .font(.system(size: UIDevice.isPad ? 60 : 30)) // 设置字体大小
            VStack(alignment: .leading, spacing: 30) { // 垂直布局，内容左对齐，间距30
                Text("switch between ♯ or ♭ symbols by tapping the tuner") // 切换音调符号的说明
                Text("turn the visualizer on and off by tapping the \(Image("visualizer-symbol")) button") // 开关可视化器的说明
                Text("change the theme by tapping anywhere on the background") // 切换主题的说明
            }
            .padding(.top) // 顶部留白
            .padding(.horizontal, UIDevice.isPad ? 60 : 20) // 水平方向留白
            HStack { // 水平布局
                Spacer() // 占位符，用于推动按钮至父视图的右侧
                Button { // 按钮
                    isFirstRun(false) // 点击按钮后调用闭包，将 isFirstRun 标记为 false
                    
                } label: {
                    Text("ok!") // 按钮文本：“OK！”
                        .fontWeight(.semibold) // 设置字体粗细
                        .font(.system(size: UIDevice.isPad ? 40 : 20)) // 设置字体大小
                        .foregroundColor(.black) // 设置文本颜色
                        .padding() // 内边距
                        .background(Color.white) // 背景颜色
                        .cornerRadius(UIDevice.isPad ? 60 : 30) // 圆角
                        .contentShape(Rectangle()) // 内容形状
                }
                .padding(.bottom, 40) // 底部留白
                .padding(.top, UIDevice.isPad ? 100 : 70) // 顶部留白
                .padding(.trailing, UIDevice.isPad ? 110 : 50) // 右侧留白
            }
        }
    }

    // 初始化方法，接受一个闭包作为参数
    init(isFirstRun: @escaping (Bool) -> Void) {
        self.isFirstRun = isFirstRun // 将闭包赋值给属性
    }
}

// 预览视图
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView() { _ in } // 创建 OnboardingView 的预览，传递一个空闭包作为参数
            .preferredColorScheme(.dark) // 设置预览的颜色方案为暗色模式
    }
}
