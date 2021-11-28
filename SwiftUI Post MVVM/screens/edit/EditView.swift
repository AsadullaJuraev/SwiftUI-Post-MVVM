//
//  EditView.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var viewModel = editViewModel()
    @Environment(\.presentationMode) var presentation
    @State var post = Post()
    @State var title = ""
    @State var bodys = ""
    var PostID: String
    
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
                        
                        Button(action: {
                            if title != "" && bodys != ""{
                                viewModel.apiEditPost(id: Int(PostID)!, post: Post(title: title, body: bodys)) { result in
                                    if result {
                                        presentation.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }){
                            
                            Text("EDIT").font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                    }.padding(.horizontal , 15)
                        .padding(.top, 20)
                }
            }
        }
        .onAppear(perform: {
            viewModel.apiCallPost(id: Int(PostID)!) { item in
                self.title = item.title ?? ""
                self.bodys = item.body ?? ""
            }
        })
    }
}
