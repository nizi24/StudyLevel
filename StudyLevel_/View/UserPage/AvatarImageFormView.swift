//
//  AvatarImageForm.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import SwiftUI

struct AvatarImageFormView: View {
    @ObservedObject var viewModel = AvatarFormViewModel()
    @State var image: Image = Image("icon")
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var size: CGFloat = 60
    @State var title = "通信中・・・"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            Form {
                Button(action: {
                    self.showingImagePicker = true
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("アイコン画像を選択")
                        Spacer()
                    }
                }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
                Section(header: Text("アップロード画像")) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .cornerRadius(size / 2)
                }
                if let error = viewModel.validationError, !error.isEmpty {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                viewModel.updateAvatar(image: inputImage)
            }, label: {
                Text("変更")
            }))
            .alert(isPresented: $viewModel.alert) {
                switch viewModel.alertType {
                case .success:
                    return Alert(title: Text("完了"), message: Text("プロフィールを変更しました。"), dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                case .error:
                    return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AvatarImageForm_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImageFormView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
