//
//  ContentView.swift
//  ViewControllerDelegatePattern
//
//  Created by hiroshi yamato on 2020/11/05.
//
import SwiftUI

struct ContentView: View, secondViewDelegate{

    @State var text: String = "not change yet"
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Main View")
                NavigationLink(
                    destination: SecondView(delegate: self, text: "Sucess send message"),
                    label: {
                        Text("Go to SecondView")
                    })
                Text(text)
            }
        }
    }
    
    func returnData(text: String) {
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


