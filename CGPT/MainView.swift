//
//  MainView.swift
//  CGPT
//
//  Created by Andrew Almasi on 12/13/22.
//

import SwiftUI
import WelcomeSheet


struct MainView: View {

    
    var body: some View {
                ContentView()
                    .ignoresSafeArea()
                    .background(Color(uiColor: UIColor().bgColor))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
