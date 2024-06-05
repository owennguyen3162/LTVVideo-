import UIKit



@IBDesignable
class DrawingCanvas: UIView {
    
    enum DrawingCanvasState {
        case ready
        case recording
    }


    
    var circleRadius: CGFloat = 30.0
    var circleShape: CGFloat = 300// Updated to store y-coordinate
  
    var displayLink: CADisplayLink?
    var direction: CGFloat = -1.0 // -1.0 for up, 1.0 for down
    var isTopState: Bool = true // Variable to determine the current state
    var currentPoint = 0.0
    var isToogle = false
    var isDone = false
    
    //Goat
    var circleImage: UIImage?
    var imagePlayer: UIImage?
    
    var imageBuffer: UIImage?
    var imageplayerBuffer: UIImage?
    
  
    var state = DrawingCanvasState.ready

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        circleShape = circleRadius
        startAnimation()
      
        
        // SetupImage
        circleImage = UIImage(named: "Scissor")
        imagePlayer = UIImage(named: "TestImage")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext(), let image = circleImage, let image2 = imagePlayer else { return }
        context.clear(rect)
        image.draw(in: moveImage())
        image2.draw(in: drawPlayer())

        drawImagePlayerToBuffer()
        drawImageBuffer()
        
//        if(!isDrawing){
          
//            isDrawing = true
//        }
       
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
        let increment: CGFloat = 2.0
        circleShape += increment * direction
        if circleShape >= (isToogle == false ? 500 : bounds.width - circleRadius) {
            if(!isToogle){
                direction = -2.0
            }else{
                stopAnimation()
            }
        } else if circleShape <= circleRadius {
            direction = 2.0
        }
        setNeedsDisplay()
    }
    
    private func moveImage () -> CGRect {
        var imageRect: CGRect
        
        if(isToogle == false){
            currentPoint = circleShape
        }

        let newSize = ResizeClass.shared.pixelPerfect(forWidth: 62, forHeight: 54)
      
        if isTopState {
            imageRect = CGRect(x: 30, y: circleShape - circleRadius, width: newSize.width , height: newSize.height)
        } else {
            imageRect = CGRect(x: circleShape , y: currentPoint - 25, width: newSize.width , height:newSize.height )
        }
        
        return imageRect
    }
    
    private func drawPlayer() -> CGRect {
        let newSize = ResizeClass.shared.pixelPerfect(forWidth: 200, forHeight: 490)
        return CGRect(x: bounds.width / 4.3, y: bounds.height / 2.7, width: newSize.width , height: newSize.height)
    }

    func drawImageBuffer() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let _ = UIGraphicsGetCurrentContext(), let image = circleImage else { return }
        image.draw(in: moveImage())
        imageBuffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    //PLayer
    func drawImagePlayerToBuffer() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let _ = UIGraphicsGetCurrentContext(), let image = imagePlayer else { return }
        image.draw(in: drawPlayer())
        imageplayerBuffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func getImageBuffer() -> UIImage? {
        return imageBuffer
    }
    
    func getImagePlayerBuffer() -> UIImage? {
        return imageplayerBuffer
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if state == .ready {
            return
        }
        
        if !isDone {
            isDone = true
            isTopState.toggle()
            isToogle = true
            stopAnimation()
            self.direction = 2.0
            self.startAnimation()
            circleShape = 30
            setNeedsDisplay()
        }
    }
    
    
    //Drawing Content Goat
    
    
    
}
