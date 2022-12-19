//
//  ResultView.swift
//  CGPT
//
//  Created by Andrew Almasi on 12/13/22.
//

import SwiftUI
struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}

struct ResultView: View {
    @State var response: String
    @State var shareText: ShareText?
    

    
    var body: some View {
        
        ZStack{
            Color(uiColor: UIColor().bgColor).edgesIgnoringSafeArea(.all)
            VStack() {
                Spacer()
                if #available(iOS 16.0, *) {
                    TextEditor(text: $response)
                    //.foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .font(.headline)
                        .background(Color(uiColor: UIColor().bgColor))
                        .foregroundColor(Color(uiColor: UIColor().tColor))
                        .padding()
                } else {
                    TextEditor(text: $response)
                    //.foregroundColor(.white)
                        .font(.headline)
                        .background(Color(uiColor: UIColor().bgColor))
                        .padding()
                }
                if #available(iOS 16.0, *) {
                    ShareLink(item: response)
                        .padding(.vertical)
                } else {
                    Text("Update to IOS 16!")
                        .padding()
                }
                Spacer()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(response: "This is just some sample text \n I dont really know what tot put here \n just for the UI. \n \n love.")
    }
}
