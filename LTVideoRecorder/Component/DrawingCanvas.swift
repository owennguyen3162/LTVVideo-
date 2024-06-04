import UIKit

@IBDesignable
class DrawingCanvas: UIView {

    var circleImage: UIImage?
    var circleRadius: CGFloat = 30.0
    var circleShape: CGFloat = 0.0 // Updated to store y-coordinate
    var imageBuffer: UIImage?
    var displayLink: CADisplayLink?
    var direction: CGFloat = -1.0 // -1.0 for up, 1.0 for down
    var isTopState: Bool = true // Variable to determine the current state
    var currentPoint = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        circleShape = circleRadius // Updated to initialize at left side
        startAnimation()

        // Load the image (replace "example.png" with your image file)
        circleImage = UIImage(named: "Scissor")
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext(), let image = circleImage else { return }
        context.clear(rect)

        var imageRect: CGRect

        // Set imageRect based on current state
        if isTopState {
            imageRect = CGRect(x: bounds.midX - circleRadius, y: circleShape - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        } else {
            imageRect = CGRect(x: circleShape - circleRadius, y: bounds.midY - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        }

        // Draw the image
        image.draw(in: imageRect)

        // Save the image to the buffer
        drawImageBuffer()
    }

    func startAnimation() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateImage))
        displayLink?.add(to: .main, forMode: .default)
    }

    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }

    @objc private func updateImage() {

        let increment: CGFloat = 2.0 // Speed of the image movement
        circleShape += increment * direction

        if circleShape >= 500 {
            direction = -1.0
        } else if circleShape <= circleRadius {
            direction = 1.0 // chay xuong duoi
        }
        setNeedsDisplay()
    }

    func drawImageBuffer() {
      
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext(), let image = circleImage else { return }

        var imageRect: CGRect
        currentPoint = circleShape
        // Set imageRect based on current state
        if isTopState {
            imageRect = CGRect(x: bounds.midX - circleRadius, y: circleShape - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        } else {
            imageRect = CGRect(x: circleShape - circleRadius, y: bounds.midY - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        }

        // Draw the image to the buffer
        image.draw(in: imageRect)

        imageBuffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func getImageBuffer() -> UIImage? {
        return imageBuffer
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Toggle the state when the user taps
        isTopState.toggle()
//        print("currentPoint \(currentPoint)")
        stopAnimation()
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {[weak self] in
            if let self = self {
                self.direction = 1.0
                self.startAnimation()
            }
        }
        // Redraw the view
        setNeedsDisplay()
    }
}
