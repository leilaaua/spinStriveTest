import SwiftUI

struct BounceAnimation: ViewModifier {
    let delay: Double
    let duration: Double
    
    @State private var offsetY: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .offset(y: offsetY)
            .onDisappear {
                self.offsetY = 0
                
            }
        
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration + delay) {
                    withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
                        offsetY = -20
                    }
                }
            }
    }
}
