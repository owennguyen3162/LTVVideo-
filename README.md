
The flow is: 
- for every frame, get CVPixelBuffer from a AVCaptureSession, convert it to a CIImage instance
- add filter to the CIImage
- add drawing and text layer to the CIImage
- render the CIImage to the screen
- write the CIImage to the file
