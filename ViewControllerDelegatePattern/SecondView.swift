//
//  SecondView.swift
//  ViewControllerDelegatePattern
//
//  Created by hiroshi yamato on 2020/11/05.
//

import SwiftUI

protocol secondViewDelegate {
    func returnData(text: String)
}


struct SecondView: View {
    var delegate: secondViewDelegate?
    let text: String
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text(text)
            Button(action: {
                self.delegate?.returnData(text: "Success!!")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Try delegate")
            })
            Button(action: {
                self.delegate?.returnData(text: "hoge!!")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Try hoge")
            })
            Button(action: {
                self.delegate?.returnData(text: "fuga!!")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Try fuga")
            })
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(text: "")
    }
}


