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
    var isToogle = false

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
        image.draw(in: moveImage())

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
        if circleShape >= (isToogle == false ? 500 : bounds.width - circleRadius) {
            if(!isToogle){
                
                direction = -1.0
            }else{
                stopAnimation()
            }
        } else if circleShape <= circleRadius {
            direction = 1.0
        }
        setNeedsDisplay()
    }
    
    private func moveImage () -> CGRect {
        var imageRect: CGRect
        
        if(isToogle == false){
            currentPoint = circleShape
        }
      
        if isTopState {
            imageRect = CGRect(x: 30, y: circleShape - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        } else {
            imageRect = CGRect(x: circleShape , y: currentPoint - 10, width: circleRadius * 2, height: circleRadius * 2)
        }
        return imageRect

    }

    func drawImageBuffer() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let _ = UIGraphicsGetCurrentContext(), let image = circleImage else { return }
        image.draw(in: moveImage())
        imageBuffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func getImageBuffer() -> UIImage? {
        return imageBuffer
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Toggle the state when the user taps
        isTopState.toggle()
        isToogle = true
//        print("currentPoint \(currentPoint)")
        stopAnimation()

            self.direction = 2.0
            self.startAnimation()
        
        circleShape = 30
       
        // Redraw the view
        setNeedsDisplay()
    }
}
