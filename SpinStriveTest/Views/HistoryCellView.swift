import SwiftUI

struct HistoryCellView: View {
    let filterEntity: FilterEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 6) {
                Rectangle()
                    .fill(Color.accentOne)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                Text(TextConstants.filters)
                    .foregroundColor(.accentOne)
                    .font(.system(size: 22, weight: .bold))
            }
            
            VStack(alignment: .leading) {
                roverTextView
                dateTextView
                cameraTextView
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundOne)
                .shadow(color: .black.opacity(0.8), radius: 16, x: 0, y: 2)
        )
    }
}
