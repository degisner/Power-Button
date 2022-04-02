import SwiftUI

struct PowerButton: View {
    @Binding var isOn: Bool

    let size: CGFloat = 136
    let innerSize: CGFloat = 128

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            ZStack {
                gapView

                Circle()
                    .foregroundColor(.pureBlack)
                    .frame(width: innerSize, height: innerSize)
                    .shadow(color: .pureBlack.opacity(0.28), radius: isOn ? 2 : 12, x: 0, y: isOn ? 2 : 24)
                    .shadow(color: .pureBlack.opacity(0.08), radius: isOn ? 2 : 6, x: 0, y: isOn ? 2 : 12)
                    .shadow(color: .pureBlack.opacity(0.24), radius: isOn ? 2 : 4, x: 0, y: isOn ? 2 : 8)
                    .overlay {
                        ZStack {
                            innerView
                            glareView
                        }
                    }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(ResetAnimation())
        .animation(.spring().speed(1.8), value: isOn)
        .keyboardShortcut(.space, modifiers: [])
    }

    var innerView: some View {
        Circle()
            .foregroundColor(Color("background"))
            .overlay {
                ZStack {
                    Circle()
                        .stroke(Color.pureBlack, lineWidth: 48)
                        .frame(width: innerSize + 52, height: innerSize + 52)
                        .shadow(
                            color: Color.white.opacity(isOn ? 0.03 : 0.04),
                            radius: 14, x: 0, y: -32
                        )
                        .background {
                            iconView
                        }

                    Circle()
                        .stroke(Color.pureBlack, lineWidth: 48)
                        .frame(width: innerSize + 52, height: innerSize + 52)
                        .shadow(
                            color: Color.pureBlack.opacity(isOn ? 0.3 : 0.28),
                            radius: 32, x: 0, y: 32
                        )

                    Circle()
                        .stroke(Color.pureBlack, lineWidth: 48)
                        .frame(width: innerSize + 52, height: innerSize + 52)
                        .shadow(
                            color: Color.pureBlack.opacity(isOn ? 0.16 : 0.12),
                            radius: 8, x: 0, y: 16
                        )
                }
            }
            .clipShape(Circle())
    }

    var iconView: some View {
        Image("icon")
            .resizable()
            .frame(width: 56, height: 56)
            .opacity(isOn ? 1 : 0.9)
    }

    var glareView: some View {
        Circle()
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [.white, .white.opacity(0.2), .white.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                ),
                lineWidth: 2
            )
            .clipShape(Circle())
            .opacity(isOn ? 0.08 : 0.2)
    }

    var gapView: some View {
        Circle()
            .foregroundColor(.pureBlack)
            .opacity(0.6)
            .overlay {
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0), .white]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
                    .clipShape(Circle())
                    .frame(width: size + 2, height: size + 2)
                    .opacity(isOn ? 0.12 : 0)
            }
    }
}

struct PowerButton_Previews: PreviewProvider {
    static var previews: some View {
        PowerButton(isOn: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding(200)
            .background(Color("background"))
    }
}
