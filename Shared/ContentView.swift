import SwiftUI

struct ContentView: View {
    @State private var isButtonOn = false
    @State private var isIndicatorOn = false

    var body: some View {
        ZStack {
            PowerButton(isOn: $isButtonOn)
                .overlay(alignment: .top) {
                    indicator
                }
        }
        .frame(width: 280, height: 280)
        .background {
            ZStack {
                Image("texture")
                    .resizable()
                    .frame(width: 400, height: 400)

                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: [.white, .white.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        .opacity(0.3)

                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black]), startPoint: .top, endPoint: .bottom)
                        .opacity(0.5)
                }
            }
        }
        .onChange(of: isButtonOn) {
            if $0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
                    isIndicatorOn = true
                }
            } else {
                isIndicatorOn = false
            }
        }
    }

    var indicator: some View {
        Circle()
            .frame(width: 4, height: 4)
            .offset(y: -12)
            .foregroundColor(isIndicatorOn ? .accentColor : .black.opacity(0.3))
            .background(alignment: .center) {
                if isIndicatorOn {
                    sparkle
                }
            }
    }

    var sparkle: some View {
        ZStack {
            Circle()
                .frame(width: 4, height: 4)
                .offset(y: -12)
                .foregroundColor(.accentColor)
                .blur(radius: 4)
                .opacity(0.6)

            Circle()
                .frame(width: 8, height: 8)
                .offset(y: -12)
                .foregroundColor(.accentColor)
                .blur(radius: 8)
                .opacity(0.4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
