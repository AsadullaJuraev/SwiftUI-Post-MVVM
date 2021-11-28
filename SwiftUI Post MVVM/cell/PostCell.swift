//
//  PostCell.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import SwiftUI

struct PostCell: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading){
            Text(post.title!.uppercased())
                .fontWeight(.bold)
            Text(post.body!)
                .padding(.top, 5)
        }.padding()
    }
}
