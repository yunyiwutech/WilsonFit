import SwiftUI

struct settingsRow:View{
    let imageName:String
    let title:String
    let tintColor:Color
    
    var body:some View{
        HStack(spacing:22){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}
#Preview{
    settingsRow(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
