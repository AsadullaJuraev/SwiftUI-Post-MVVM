//
//  CreateView.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import SwiftUI

struct CreateView: View {
    @ObservedObject var viewModel = createViewModel()
    @Environment(\.presentationMode) var presentation
    @State private var title = ""
    @State private var bodys = ""
    var body: some View {
        ZStack{
            if viewModel.isLoading {
                ProgressView()
            }else{
                GeometryReader{ geo in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("TITLE").font(.headline)
                        
                        TextField("Enter title", text: $title)
                            .padding(.horizontal , 15)
                            .frame(height: 40.0)
                            .background(Color(red: 239/255, green: 243/255, blue: 244/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("BODY").font(.headline)
                        
                        TextField("Enter body", text: $bodys)
                            .padding(.horizontal , 15)
                            .frame(height: 40.0)
                            .background(Color(red: 239/255, green: 243/255, blue: 244/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }.padding(.horizontal , 15)
                        .padding(.top, 20)
                }
            }
        }
        .navigationBarItems(trailing:
                                Button(action:{
            if title != "" && bodys != ""{
                viewModel.apiCreatePost(post: Post(title: title, body: bodys)) { result in
                    if result {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }){
            Image("ic_add")
                .foregroundColor(.white)
        }
        )
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
