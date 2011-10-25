#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>





extern int time_s;



@protocol record_audio_Delegate;

@interface record_audio_testViewController : UIViewController <AVAudioRecorderDelegate,UIPickerViewDelegate, UIPickerViewDataSource> {

//UIPickerViewDelegate, UIPickerViewDataSource> {

	int tmps;
    IBOutlet UILabel *mlabel;
    NSMutableArray *arrayNo;
    IBOutlet UIPickerView *pickerView;
	
	NSTimer* timer;
	
	UILabel *myLabel;
	UILabel *myLabel2;
	UILabel *myLabel3;
	
	IBOutlet UIButton * btnStart;
	IBOutlet UIButton * btnPlay;
	IBOutlet UIActivityIndicatorView * actSpinner;
	BOOL toggle;
	
	//Variables setup for access in the class:
	NSURL * recordedTmpFile;
	AVAudioRecorder * recorder;
	NSError * error;
	
	
	id<record_audio_Delegate> delegate;
	
	
}

//@property (nonatomic, retain) UILabel *mlabel;



@property (nonatomic, assign) id<record_audio_Delegate> delegate;

- (IBAction)done:(id)sender;
- (id)initWithDelegate:(id<record_audio_Delegate>)delegate;



@property (nonatomic, retain) UILabel *mlabel;

@property (nonatomic, retain) IBOutlet UILabel *myLabel;
@property (nonatomic, retain) IBOutlet UILabel *myLabel2;
@property (nonatomic, retain) IBOutlet UILabel *myLabel3;

@property (nonatomic,retain)IBOutlet UIActivityIndicatorView * actSpinner;
@property (nonatomic,retain)IBOutlet UIButton * btnStart;
@property (nonatomic,retain)IBOutlet UIButton * btnPlay;

- (IBAction) start_button_pressed;
- (IBAction) play_button_pressed;


- (IBAction)showInfo3:(id)sender;

@end




@protocol record_audio_Delegate
- (void)record_audio_Controller:(record_audio_testViewController*)controller didScanResult:(NSString *)result;
- (void)record_audio_ControllerDidCancel:(record_audio_testViewController*)controller;
@end

