import SwiftUI

struct CustomNavBarView: View {
    @Binding var pickerType: PickerTypeEnum?
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 22) {
            HStack {
                headerWithDate
                
                Spacer()
                
                calendarButton
            }
            
            HStack(spacing: 23) {
                HStack(spacing: 12) {
                    roverButton
                    
                    cameraButton
                }
                addButton
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.accentOne.edgesIgnoringSafeArea(.top))
    }
}

#Preview {
    CustomNavBarView(pickerType: .constant(nil), selectedDate: .constant(Date()))
}
