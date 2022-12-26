//
//  
//  HomeView.swift
//  MeditoTV
//
//  Created by Martin Lukacs on 25/12/2022.
//
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        Text("Add some view here")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
