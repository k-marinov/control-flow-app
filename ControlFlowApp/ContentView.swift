//
//  ContentView.swift
//  ControlFlowApp
//
//  Created by Keran Marinov on 02/10/2020.
//  Copyright © 2020 KM LTD. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        let isProduction = true
        return when(isProduction)
            .then(productionView)
            .else(debugView)
    }

    private var debugView: some View {
        Text("debug mode")
    }

    private var productionView: some View {
        List {
            Text("Production 1")
            Text("Production 2")
            Text("Production 3")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
