import SwiftUI

extension View {
    func compatibleFullScreen<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(FullScreenModifier(isPresented: isPresented, builder: content))
    }
}
