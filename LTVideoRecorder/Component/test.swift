//import UIKit
//
//@IBDesignable
//class DrawingCanvas: UIView {
//
//    var circleImage: UIImage?
//    var circleRadius: CGFloat = 30.0
//    var circleY: CGFloat = 0.0 // Updated to store y-coordinate
//    var verticalDirection: CGFloat = 1.0 // 1.0 for down, -1.0 for up
//    var imageBuffer: UIImage?
//
//    var displayLink: CADisplayLink?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    private func setup() {
//        // Initialize the circle at the top of the view
//        circleY = circleRadius
//        startAnimation()
//
//        // Load the image (replace "example.png" with your image file)
//        circleImage = UIImage(named: "Scissor")
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext(), let image = circleImage else { return }
//        context.clear(rect)
//
//        // Calculate the rectangle to draw the image in
//        let imageRect = CGRect(x: rect.midX - circleRadius, y: circleY - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
//
//        // Draw the image
//        image.draw(in: imageRect)
//
//        // Save the image to the buffer
//        drawImageBuffer()
//    }
//
//    func startAnimation() {
//        displayLink = CADisplayLink(target: self, selector: #selector(updateImage))
//        displayLink?.add(to: .main, forMode: .default)
//    }
//
//    func stopAnimation() {
//        displayLink?.invalidate()
//        displayLink = nil
//    }
//
//    @objc private func updateImage() {
//        let increment: CGFloat = 2.0 // Speed of the image movement
//        circleY += increment * verticalDirection
//
//        // Change direction if the image hits the top or bottom of the view
//        if circleY >= bounds.height - circleRadius {
//            verticalDirection = -1.0
//        } else if circleY <= circleRadius {
//            verticalDirection = 1.0
//        }
//        // Redraw the view
//        setNeedsDisplay()
//    }
//
//    func drawImageBuffer() {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
//        guard let context = UIGraphicsGetCurrentContext(), let image = circleImage else { return }
//
//        // Calculate the rectangle to draw the image in
//        let imageRect = CGRect(x: bounds.midX - circleRadius, y: circleY - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
//
//        // Draw the image to the buffer
//        image.draw(in: imageRect)
//
//        imageBuffer = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//    }
//
//    func getImageBuffer() -> UIImage? {
//        return imageBuffer
//    }
//}
