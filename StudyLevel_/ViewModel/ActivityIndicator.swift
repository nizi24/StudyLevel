import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    public var style = UIActivityIndicatorView.Style.medium
    
    @Binding var animating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        print("makeUIView")
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        print("updateUIView \(animating)")
        if animating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
}

struct ActivityIndicatorTEST: UIViewRepresentable {
    
    public var style = UIActivityIndicatorView.Style.medium
    
    init() {
        print("init")
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        print("makeUIView")
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        print("updateUIView")
        uiView.startAnimating()
    }
    
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorTEST()
    }
}
