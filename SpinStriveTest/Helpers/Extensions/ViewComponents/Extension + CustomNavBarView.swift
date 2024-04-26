import SwiftUI

extension CustomNavBarView {
    var addButton: some View {
        Button {
            
        } label: {
            Image(IconConstants.addIcon)
                .resizable()
                .frame(width: 24, height: 24)
                .frame(width: 38, height: 38)
                .background(Color.backgroundOne)
                .cornerRadius(10)
        }
    }
    
    var cameraButton: some View {
        Button {
            pickerType = .camera
        } label: {
            HStack(spacing: 6) {
                Image(IconConstants.cameraIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 7)
                    .padding(.vertical, 7)
                
                Text(TextConstants.cameraHeader)
                    .foregroundColor(.layerOne)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }
            .frame(width: 140, height: 38)
            .background(Color.backgroundOne, alignment: .leading)
            .cornerRadius(10)
        }
    }
    
    var roverButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                pickerType = .rover
            }
        } label: {
            HStack(spacing: 6) {
                Image(IconConstants.roverIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 7)
                    .padding(.vertical, 7)
                
                Text(TextConstants.roverHeader)
                    .foregroundColor(.layerOne)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }
            .frame(width: 140, height: 38)
            .background(Color.backgroundOne)
            .cornerRadius(10)
        }
    }
    
    var calendarButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                pickerType = .calendar
            }
        } label: {
            Image(IconConstants.calendarIcon)
                .resizable()
                .frame(width: 30, height: 34)
        }
    }
    
    var headerWithDate: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(TextConstants.marsHeader)
                .foregroundColor(.layerOne)
                .font(.largeTitle)
                .bold()
            
            Text(selectedDate.convertToString(with: "MMMM d, yyyy"))
                .foregroundColor(.layerOne)
                .font(.system(size: 17, weight: .bold))
        }
    }
}
