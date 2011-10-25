#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>


#import <MediaPlayer/MediaPlayer.h>





@protocol MyAVDelegate;

/*!
 @class	AVController 
 @author Benjamin Loulier
 
 @brief    Controller to demonstrate how we can have a direct access to the camera using the iPhone SDK 4
 */
@interface MyAVController : UIViewController <UINavigationControllerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate> {

	AVCaptureSession *_captureSession;
	AVCaptureVideoPreviewLayer *_prevLayer;
	
	id<MyAVDelegate> delegate;
	
	UIButton *_button;
}



@property (nonatomic, retain) UIButton* button;
/*!
 @brief	The capture session takes the input from the camera and capture it
 */
@property (nonatomic, retain) AVCaptureSession *captureSession;

/*
 @brief	The CALAyer customized by apple to display the video corresponding to a capture session
 */
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *prevLayer;


@property (nonatomic, assign) id<MyAVDelegate> delegate;

- (IBAction)done:(id)sender;
- (id)initWithDelegate:(id<MyAVDelegate>)delegate;



/*!
 @brief	This method initializes the capture session
 */
- (void)initCapture;


@end


@protocol MyAVDelegate
- (void)myavController:(MyAVController*)controller didScanResult:(NSString *)result;
- (void)myavControllerDidCancel:(MyAVController*)controller;
@end