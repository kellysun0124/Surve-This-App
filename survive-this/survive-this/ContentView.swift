//
//  ContentView.swift
//  survive-this
//
//  Created by Kelly Sun on 11/3/23.
//
// tutorials/resources used:
// coreML MobileNetV2FP16
// https://developer.apple.com/machine-learning/models/
// https://posturenet.app/blog/object-recognition-with-coreml-vision-and-swiftui-on-ios/
// https://www.createwithswift.com/tutorial-core-ml-using-an-image-classification-machine-learning-model-in-an-ios-app-with-swiftui/
// https://medium.com/@mohamed2nouri/machine-learning-on-ios-image-classification-mobilenetv2-d0c42400bb70
// used chaptGPT3.5 to generate specifically 'survival tips' for 'wild animal' for json file (ONLY)

import SwiftUI
import Foundation

struct ContentView: View {
 
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType?
    
    @ObservedObject var imageClassifier = ImageClassifier()
    
    
    let animalList = jsonLoader.load(jsonFileName: "danger_animals")!
    //var animal: AnimalItem?

    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.0)
                .scaledToFill()
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
    

                        }
                    }
                )
            
            
            VStack{
                Group {
                    if let imageClass = imageClassifier.imageClass {
                        VStack {
                            Text(imageClass).font(.title).bold()
                            Text(animal_info(name: imageClass))
                                .multilineTextAlignment(.center)
                                .padding(.top, -5.0)
                            Divider()
                                .padding(.bottom)
                        }
                    }
                }
                HStack {
                    
                    Button(action: {
                        if uiImage != nil {
                            imageClassifier.detect(uiImage: uiImage!)
                        }
                    }) {
                        Image(systemName: "camera")
                            .padding(.trailing)
                            .onTapGesture {
                            sourceType = .camera
                            isPresenting =  true
                            }
                    }
                    .font(.title)
                    .foregroundColor(.blue)
                    
                    Button(action: {
                        if uiImage != nil {
                            imageClassifier.detect(uiImage: uiImage!)
                        }
                    }) {
                        
                        Image(systemName: "photo")
                            .padding(.leading)
                            .onTapGesture {
                                sourceType = .photoLibrary
                                isPresenting = true
                            }
                            }.font(.title)
                            .foregroundColor(.blue)
                    
                }
            }
        }

        .sheet(isPresented: $isPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        imageClassifier.detect(uiImage: uiImage!)
                    }
                }
            
        }
        
        .padding()
    }

    private func animal_info(name: String)-> String {
        var give_pls: String = "Not a wild animal, proceed with common sense and you should be ok"
        animalList.wild_animals.forEach { wild_animal in
            if wild_animal.name == name {
                give_pls = wild_animal.survival_guide
            }
        }
        return give_pls
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageClassifier: ImageClassifier())
    }
}





//second attempt, with photo picker 2:31pm
//import SwiftUI
//
//struct ContentView: View {
//
//    @State var isPresenting: Bool = false
//    @State var uiImage: UIImage?
//    
//    //    let model: MobileNetV2FP16 = {
//    //
//    //            do {
//    //
//    //                let config = MLModelConfiguration()
//    //                return try MobileNetV2FP16(configuration: config)
//    //
//    //            } catch {
//    //
//    //                print(error)
//    //                fatalError("Couldn't create MobileNetV2FP16")
//    //
//    //            }
//    //    }()
//    //
//    //    @State private var classificationLabel: String = ""
//
//            
//        
//    var body: some View {
//        VStack{
//            HStack{
//                Image(systemName: "photo")
//                  .onTapGesture {
//                    isPresenting = true
//                }
//
//                Image(systemName: "camera")
//            }
//            .font(.largeTitle)
//            .foregroundColor(.blue)
//
//          Rectangle()
//            .strokeBorder()
//            .foregroundColor(.yellow)
//            .overlay(
//                Group {
//                    if uiImage != nil {
//                        Image(uiImage: uiImage!)
//                            .resizable()
//                            .scaledToFit()
//                    }
//                }
//            )
//            
//            // The button we will use to classify the image using our model
//            Button("Classify", action: {
//
//                if uiImage != nil {
//                    Classifier().classifyImage(photo: uiImage!)
//                } else {
//                    print("cannot classify image")
//                }
//            })
//            .padding()
//            .foregroundColor(Color.white)
//            .background(Color.green)
//
//            // The Text View that we will use to display the results of the classification
//
//            Text(Classifier().classificationLabel)
//                    .padding()
//                    .font(.body)
//            
////            Button(action: {
////                if uiImage != nil {
////                    guard let ciImage = CIImage(image: uiImage!) else {
////                        print ("cannot convert UIIMage to CIImage")
////                        return
////                    }
////                    Classifier.detect(ciImage: ciImage)
////                }
////            })
////            { Image(systemName: "bolt.fill").foregroundColor(.red).font(.title) }
//        }
//        .sheet(isPresented: $isPresenting){
//          ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting)
//    }
//    .padding()
//
//    }
//}
//
//
//
//struct ContentView_Previews: PreviewProvider {
//
//  static var previews: some View {
//
//    ContentView()
//
//  }
//
//}







//first attempt MobileNetV2FP16, no photo picker
//import SwiftUI
//import SwiftData
//import CoreML
//import CoreImage
//import Vision
//
//struct ContentView: View {
////    let model = MobileNetV2FP16(configuration: MLModelConfiguration())
////    guard let model = try? type(of: MobileNetV2FP16()).init() else {
////        fatalError("failed to load core ml model")
////    }
////    guard let model = try? VNCoreMLModel(for: MobileNetV2FP16(configuration: MLModelConfiguration()).model) else {
////        return
////    }
//
//    let model: MobileNetV2FP16 = {
//            
//            do {
//                
//                let config = MLModelConfiguration()
//                return try MobileNetV2FP16(configuration: config)
//                
//            } catch {
//                
//                print(error)
//                fatalError("Couldn't create MobileNetV2FP16")
//                
//            }
//    }()
//    
//    @State private var classificationLabel: String = ""
//
//    
//    let photos = ["pineapple", "strawberry", "lemon"]
//    @State private var currentIndex: Int = 0
//
//    
//    
//    var body: some View {
//        VStack {
////            Image("lemon")
////                .resizable()
////                .frame(width: 200, height: 200)
//            Image(photos[currentIndex]).resizable().frame(width: 200, height: 200)
//            Spacer()
//            
//            VStack {
//                HStack {
//                    Button("Back") {
//                        if self.currentIndex >= self.photos.count {
//                            self.currentIndex = self.currentIndex - 1
//                        } else {
//                            self.currentIndex = 0
//                        }
//                    }
//                    .padding()
//                    .foregroundColor(Color.white)
//                    .background(Color.gray)
//
//                    Button("Next") {
//                        if self.currentIndex < self.photos.count - 1 {
//                            self.currentIndex = self.currentIndex + 1
//                        } else {
//                            self.currentIndex = 0
//                        }
//                    }
//                    .padding()
//                    .foregroundColor(Color.white)
//                    .background(Color.gray)
//                    
//                }
//                Spacer()
//                
//                VStack {
//                    // The button we will use to classify the image using our model
//                    Button("Classify") {
//                        classifyImage(photo: photos[currentIndex])
//                    }
//                    .padding()
//                    .foregroundColor(Color.white)
//                    .background(Color.green)
//
//                    // The Text View that we will use to display the results of the classification
//
//                        Text(classificationLabel)
//                            .padding()
//                            .font(.body)
//                    Spacer()
//                    
//                }
//            }
//            
//        }
//    }
//
//
//    
//    private func classifyImage(photo: String){
//        let image = UIImage(named: photo)!
//        
//        if let imagebuffer = image.convertImage(image: image) {
//            do {
//                let prediction = try model.prediction(image: imagebuffer)
//                classificationLabel = prediction.classLabel
//            } catch let error {
//                print("error: ", error)
//            }
//        }
//    }
//    
//}



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


