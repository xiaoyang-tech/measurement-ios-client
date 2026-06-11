import SwiftUI

/// Welcome screen that presents measurement instructions and a start button.
struct MaskView: View {

    // MARK: - Properties

    /// Controls whether the view is visible.
    @Binding var isPresented: Bool

    /// Whether the start button should show a loading indicator.
    let isLoading: Bool

    /// Callback fired when the user taps the start button.
    let onStart: () -> Void

    // MARK: - Body

    var body: some View {
        ZStack {
            if isPresented {
                Color.white
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    Spacer()

                    // Face guide frame
                    Image("default")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 5)
                                    .padding(-5)
                                    .frame(height: 370)

                                Circle()
                                    .stroke(Color.black.opacity(0.1), lineWidth: 5)
                                    .frame(width: 10, height: 10)
                                    .offset(y: -170)
                            }
                        )

                    // Instructions
                    Text("测量时请注视摄像头")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(red: 26/255, green: 26/255, blue: 26/255))
                        .padding(.top, 40)

                    Text("请保持面部轮廓在取景框中根据屏幕提示完成测量")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)

                    Spacer()

                    // Start button
                    VStack {
                        Button(action: {
                            if !isLoading {
                                onStart()
                            }
                        }) {
                            HStack(spacing: 8) {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                }
                                Text("开始测量")
                            }
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: 500)
                            .frame(height: 60)
                            .background(
                                isLoading
                                    ? Color(red: 38/255, green: 135/255, blue: 254/255, opacity: 0.3)
                                    : Color(red: 38/255, green: 135/255, blue: 254/255)
                            )
                            .cornerRadius(30)
                            .shadow(color: Color(red: 29/255, green: 135/255, blue: 240/255).opacity(0.3), radius: 15, x: 0, y: 18)
                        }
                        .padding(.horizontal, 40)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.15)
                }
            }
        }
        .animation(.default, value: isPresented)
    }
}


// MARK: - Preview

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView(
            isPresented: .constant(true),
            isLoading: false,
            onStart: { print("Start tapped.") }
        )

        MaskView(
            isPresented: .constant(true),
            isLoading: true,
            onStart: {}
        )
        .previewDisplayName("Loading State")
    }
}
