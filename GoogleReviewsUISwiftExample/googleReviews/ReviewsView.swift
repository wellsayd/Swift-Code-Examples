//
//  Reviews.swift
//  googleReviews
//
//  Created by bwells on 11/29/22.
//

import SwiftUI
import SafariServices

struct NoReviews: View {
    
    var body: some View {
        
        let hstack = HStack()
        {
            Text("No Reviews")
        }
        return hstack
    }
    
}

struct ReviewsView: View {
    
    @Binding var isPresented: Bool
    @Binding var results: ResultData
    @State var showSafari = false
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading)
                {
                    
                    Button(action: {
                        self.showSafari = true
                    }, label: {
                        Text("See All Reviews")
                    })
                    .sheet(isPresented: $showSafari) {
                        SafariView(url:URL(string: self.results.result.url)!)
                    }
                    
                    Divider()
                    
                    ForEach(0..<results.result.reviews.count, id: \.self) { i in
                        HStack(){
                            AsyncImage(
                                url: URL(string: results.result.reviews[i].profile_photo_url),
                                content: { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(maxWidth: 22, maxHeight: 22)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )

                            Text(results.result.reviews[i].author_name + ": " )
                            Text(String(results.result.reviews[i].rating))
                            StarsView(wholeNum: self.results.result.reviews[i].rating, remainderNum: self.results.result.reviews[i].rating.truncatingRemainder(dividingBy: 1))
                        }
                        
                        Text(results.result.reviews[i].text)
                        
                        if(i < (results.result.reviews.count - 1)) {
                            Divider()
                        }
                    }
                }
            }
            .navigationTitle("User Rating/Reviews")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                Button(action: {
                                    self.isPresented.toggle()
                                }, label: {
                                    Text("Close")
                                        .foregroundColor(.blue)
                                })
          
            )
        }
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}


