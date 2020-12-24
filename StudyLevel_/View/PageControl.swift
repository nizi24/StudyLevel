import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

struct PageControlPreview: View {
    @State var pageNo = 1
    var body: some View {
                VStack {
            Stepper(value: $pageNo, in: 0...20) {
                Text("pageNo \(pageNo)")
            }.fixedSize()
            PageControl(numberOfPages: 20, currentPage: $pageNo)
        }.frame(minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity)
            .background(Color.gray)
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PageControl(numberOfPages: 20,
                        currentPage:.constant(10))

        }.frame(minWidth: 0, maxWidth: .infinity,
                minHeight: 0, maxHeight: .infinity)
            .background(Color.gray)
        
    }
}
