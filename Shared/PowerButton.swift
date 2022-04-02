import SwiftUI

struct PowerButton: View {
    @Binding var isOn: Bool

    let size: CGFloat = 68
    let innerSize: CGFloat = 64

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            ZStack {
                gapView

                Circle()
                    .frame(width: innerSize, height: innerSize)
                    .shadow(color: .black.opacity(0.28), radius: isOn ? 1 : 6, x: 0, y: isOn ? 1 : 12)
                    .shadow(color: .black.opacity(0.08), radius: isOn ? 1 : 3, x: 0, y: isOn ? 1 : 6)
                    .shadow(color: .black.opacity(0.24), radius: isOn ? 1 : 2, x: 0, y: isOn ? 1 : 4)
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
                        .stroke(Color.black, lineWidth: 24)
                        .frame(width: innerSize + 26, height: innerSize + 26)
                        .shadow(
                            color: Color.white.opacity(isOn ? 0.03 : 0.04),
                            radius: 7, x: 0, y: -16
                        )
                        .background {
                            iconView
                        }

                    Circle()
                        .stroke(Color.black, lineWidth: 24)
                        .frame(width: innerSize + 26, height: innerSize + 26)
                        .shadow(
                            color: Color.black.opacity(isOn ? 0.3 : 0.28),
                            radius: 16, x: 0, y: 16
                        )

                    Circle()
                        .stroke(Color.black, lineWidth: 24)
                        .frame(width: innerSize + 26, height: innerSize + 26)
                        .shadow(
                            color: Color.black.opacity(isOn ? 0.16 : 0.12),
                            radius: 4, x: 0, y: 8
                        )
                }
            }
            .clipShape(Circle())
    }

    var iconView: some View {
        Image("icon")
            .resizable()
            .frame(width: 28, height: 28)
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
            .opacity(isOn ? 0.09 : 0.2)
    }

    var gapView: some View {
        Circle()
            .foregroundColor(.pureBlack)
            .opacity(0.5)
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
