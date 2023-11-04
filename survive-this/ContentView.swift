//
//  ContentView.swift
//  survive-this
//
//  Created by Kelly Sun on 11/3/23.
//

import SwiftUI
import SwiftData
import CoreML
import CoreImage
import Vision

struct ContentView: View {
//    let model = MobileNetV2FP16(configuration: MLModelConfiguration())
//    guard let model = try? type(of: MobileNetV2FP16()).init() else {
//        fatalError("failed to load core ml model")
//    }
//    guard let model = try? VNCoreMLModel(for: MobileNetV2FP16(configuration: MLModelConfiguration()).model) else {
//        return
//    }

    let model: MobileNetV2FP16 = {
            
            do {
                
                let config = MLModelConfiguration()
                return try MobileNetV2FP16(configuration: config)
                
            } catch {
                
                print(error)
                fatalError("Couldn't create MobileNetV2FP16")
                
            }
    }()
    
    @State private var classificationLabel: String = ""

    
    let photos = ["pineapple", "strawberry", "lemon"]
    @State private var currentIndex: Int = 0

    
    
    var body: some View {
        VStack {
//            Image("lemon")
//                .resizable()
//                .frame(width: 200, height: 200)
            Image(photos[currentIndex]).resizable().frame(width: 200, height: 200)
            Spacer()
            
            VStack {
                HStack {
                    Button("Back") {
                        if self.currentIndex >= self.photos.count {
                            self.currentIndex = self.currentIndex - 1
                        } else {
                            self.currentIndex = 0
                        }
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)

                    Button("Next") {
                        if self.currentIndex < self.photos.count - 1 {
                            self.currentIndex = self.currentIndex + 1
                        } else {
                            self.currentIndex = 0
                        }
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    
                }
                Spacer()
                
                VStack {
                    // The button we will use to classify the image using our model
                    Button("Classify") {
                        classifyImage(photo: photos[currentIndex])
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    
                    // The Text View that we will use to display the results of the classification
                    
                        Text(classificationLabel)
                            .padding()
                            .font(.body)
                    Spacer()
                    
                }
            }
            
        }
    }


    
    private func classifyImage(photo: String){
        let image = UIImage(named: photo)!
        
        if let imagebuffer = image.convertImage(image: image) {
            do {
                let prediction = try model.prediction(image: imagebuffer)
                classificationLabel = prediction.classLabel
            } catch let error {
                print("error: ", error)
            }
        }
    }
    
}



//struct ContentView: View {
//
//    
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}


