//
//  HomeView.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = homeViewModel()
    @State private var showEdit = false
    
    func delete(indexSet: IndexSet) {
        let post = viewModel.post[indexSet.first!]
        viewModel.apiPostDelete(post: post, completion: { status in
            if status{
                viewModel.apiPostList()
            }else{
                //error message
            }
        })
    }
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    ForEach(0..<viewModel.post.count, id:\.self) { index in
                        Button {
                            showEdit.toggle()
                        } label: {
                            PostCell(post: viewModel.post[index])
                            
                        }
                        .sheet(isPresented: $showEdit){
                            EditView(PostID: viewModel.post[index].id!)
                                .onDisappear{
                                    viewModel.apiPostList()
                                }
                        }
                        
                        
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(PlainListStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {
                viewModel.apiPostList()
            }){
                Image("ic_refresh")
                    .foregroundColor(.white)
            }
                                , trailing:
                                    NavigationLink(destination: {
                CreateView()
                    .onDisappear{
                        viewModel.apiPostList()
                    }
            }, label: {
                Image("ic_add")
                    .foregroundColor(.white)
            })
            )
            .navigationBarTitle("SwiftUI MVVM", displayMode: .inline)
            .background(UINavigationConfiguration { nc in
                
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .gray
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                
                // Customizing our navigation bar
                nc.navigationBar.tintColor = .white
                nc.navigationBar.standardAppearance = appearance
                nc.navigationBar.scrollEdgeAppearance = appearance
                nc.navigationBar.shadowImage = UIImage()
            })
        }
        .onAppear{
            viewModel.apiPostList()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
