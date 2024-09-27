//
//  ContentView.swift
//  Example
//
//  Created by Alonso on 3/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(LocalizedStrings.helloWorld())
            Text(LocalizedStrings.byeWorld())
            Text(LocalizedStrings.bye_world())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
