//
//  ContentView.swift
//  AsyncImageExample
//
//  Created by Fatih Durmaz on 22.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var photos: [Photo] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    LazyVStack{
                        ForEach (photos) { photo in
                            AsyncImage(url: photo.url){ phase in
                                switch phase{
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(.rect(cornerRadius: 8))
                                case .failure:
                                    Color.red
                                    
                                case .empty:
                                    ProgressView()
                                @unknown default:
                                    EmptyView()
                                }
                            }

                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.4)
                        }
                    }
                }
                .padding()
                .onAppear{
                    self.photos = decodeImageData()
                    UIScrollView.appearance().bounces = true

                }

            }
            .navigationTitle("AsyncImage")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.teal)
        }
    }
}

func decodeImageData() -> [Photo] {
    let jsonData = """
        
        [
            {
            "url": "https://api.slingacademy.com/public/sample-photos/6.jpeg",
            "id": 6
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/7.jpeg",
            "id": 7
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/8.jpeg",
            "id": 8
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/9.jpeg",
            "id": 9
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/10.jpeg",
            "id": 10
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/11.jpeg",
            "id": 11
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/12.jpeg",
            "id": 12,
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/13.jpeg",
            "id": 13
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/14.jpeg",
            "id": 14
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/15.jpeg",
            "id": 15
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/16.jpeg",
            "id": 16
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/17.jpeg",
            "id": 17
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/18.jpeg",
            "id": 18
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/19.jpeg",
            "id": 19
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/20.jpeg",
            "id": 20
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/21.jpeg",
            "id": 21
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/22.jpeg",
            "id": 22
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/23.jpeg",
            "id": 23
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/24.jpeg",
            "id": 24
            },
            {
            "url": "https://api.slingacademy.com/public/sample-photos/25.jpeg",
            "id": 25
            }
        ]
        
        """.data(using: .utf8)!
    
    do {
        let data = try JSONDecoder().decode([Photo].self, from: jsonData)
        return data
    } catch {
        print("JSON dönüştürme hatası: \(error)")
        return []
    }
}

#Preview {
    ContentView()
}
