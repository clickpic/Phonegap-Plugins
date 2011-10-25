#import "record_audio_testViewController.h"
#include "audio_sdk.h";

int time_s;
@implementation record_audio_testViewController
@synthesize actSpinner, btnStart, btnPlay, myLabel, myLabel2, myLabel3, mlabel, delegate;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	
	
	
    arrayNo = [[NSMutableArray alloc] init];
	
    [arrayNo addObject:@"5"];
    [arrayNo addObject:@"10"];
    [arrayNo addObject:@"15"];
    [arrayNo addObject:@"20"];
    [arrayNo addObject:@"30"];
    tmps=15;
    [pickerView selectRow:2 inComponent:0 animated:NO];
    mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];  

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Start the toggle in true mode.
	toggle = YES;
	btnPlay.hidden = YES;

	//Instanciate an instance of the AVAudioSession object.
	AVAudioSession * audioSession = [AVAudioSession sharedInstance];

	

	//Setup the audioSession for playback and record. 
	//We could just use record and then switch it to playback leter, but
	//since we are going to do both lets set it up once.
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];

	
	UInt32 doChangeDefaultRoute = 1;
	AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
	
	//UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
	//AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
	
	//Activate the session
	[audioSession setActive:YES error: &error];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)  start_button_pressed{

	if(toggle)
	{
		time_s=0;
		toggle = NO;
		[actSpinner startAnimating];
		//[btnStart setTitle:@"Stop Recording" forState: UIControlStateNormal ];	
		btnStart.enabled = toggle;
		btnStart.hidden = !toggle;
		
		//printf("--> filenameaaa %s\n\n",(*kdbs).getFileName(10).c_str());

		
		NSString * theValue4 = [NSString stringWithFormat:@""];
		
		[myLabel2 setText:theValue4];
		
//		myLabel2.hidden = YES;
//		myLabel3.hidden = YES;
		
		//Begin the recording session.
		//Error handling removed.  Please add to your own code.
				
		//Setup the dictionary object with all the recording settings that this 
		//Recording sessoin will use
		//Its not clear to me which of these are required and which are the bare minimum.
		//This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
		NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];

		[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
//		[recordSetting setValue :[NSNumber numberWithInt:kAudioFileWAVEType] forKey:AVFormatIDKey];
		[recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey]; 
		[recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];

		[recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey]; 
		[recordSetting setValue:[NSNumber numberWithBool: NO] forKey:AVLinearPCMIsBigEndianKey];
//		[recordSetting setValue:[NSNumber numberWithBool: NO] forKey:AVLinearPCMIsFloatKey];
		
		//Now that we have our settings we are going to instanciate an instance of our recorder instance.
		//Generate a temp file for use by the recording.
		//This sample was one I found online and seems to be a good choice for making a tmp file that
		//will not overwrite an existing one.
		//I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
		recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"wav"]]];
		NSLog(@"Using File called: %@",recordedTmpFile);
		//Setup the recorder to use this file and record to it.
		recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
		//Use the recorder to start the recording.
		//Im not sure why we set the delegate to self yet.  
		//Found this in antother example, but Im fuzzy on this still.
		[recorder setDelegate:self];
		//We call this to start the recording process and initialize 
		//the subsstems so that when we actually say "record" it starts right away.
		[recorder prepareToRecord];
		//Start the actual Recording
		[recorder record];
		//There is an optional method for doing the recording for a limited time see 
		//[recorder recordForDuration:(NSTimeInterval) 10]
		
		
		time_s++;
//		NSString *theValue = [NSString stringWithFormat:@"Ouvindo... %d",time_s];
//		[myLabel setText:theValue];
		
		timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveRect) userInfo:nil repeats:YES];
		
		
	}
	else
	{
		
		[timer invalidate];	

		toggle = YES;
		[actSpinner stopAnimating];
		//[btnStart setTitle:@"Start Recording" forState:UIControlStateNormal ];
		btnStart.enabled = toggle;
		btnStart.hidden = !toggle;
		
		NSLog(@"Using File called: %@",recordedTmpFile);
		//Stop the recorder.
		[recorder stop];
	}
}





-(void)moveRect
{
	//	NSString *v = [NSString stringWithFormat:@"%s",[pickerView selectedRowInComponent:0]];
//	NSString *v = [NSString stringWithFormat:@"%s",[pickerView selectedRowInComponent:0]];

//int limit=[tmps intValue];
//[myLabel setText:tmps];
	int limit=tmps;
	//[v intValue];
//	NSString *theValue = [NSString stringWithFormat:@"%d!",(int)(rand()%100)];

  if(time_s!=-1)
  {
	  if(time_s==limit) {
		  
		  NSString *theValue = [NSString stringWithFormat:@"Analyzing..."];
		  [myLabel setText:theValue];
		  time_s++;
	  }
	else if(time_s>limit) 
	{
		
		
		
		[timer invalidate];	
		
		
		
		toggle = YES;
		//[btnStart setTitle:@"Start Recording" forState:UIControlStateNormal ];
		btnStart.enabled = toggle;
		btnStart.hidden = !toggle;
		
		NSLog(@"Using File called: %@",recordedTmpFile);
		//Stop the recorder.
		[recorder stop];
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		
		
		//	FILE *f = fopen([path cStringUsingEncoding:1],"r");
		//	if (f == NULL) NSLog([path stringByAppendingString:@" not found"]);
		//	wavtest([path cStringUsingEncoding:1],[path2 cStringUsingEncoding:1],[path3 cStringUsingEncoding:1]);
		//	NSString *theValue = [NSString stringWithFormat:@"%d", test123(100)];
		
		
		NSString *urlString = [recordedTmpFile path];

		//	NSString *theValue = [NSString stringWithFormat:@"Done is %d s!",wavtest([path cStringUsingEncoding:1],[urlString cStringUsingEncoding:1],[path3 cStringUsingEncoding:1],[path4 cStringUsingEncoding:1],[path5 cStringUsingEncoding:1],[path6 cStringUsingEncoding:1])];

		search_result rrr;
		//testing(test1);
		
//		int rsi=0;		
		int rsi=wavtest2(test1,test2,&rrr,(char*)[urlString cStringUsingEncoding:1]);
//		int rsi=wavtest2((*kdbs),(*tables),&rrr,(char*)[path cStringUsingEncoding:1],(char*)[urlString cStringUsingEncoding:1],(char*)[path3 cStringUsingEncoding:1],(char*)[path4 cStringUsingEncoding:1],(char*)[path5 cStringUsingEncoding:1],(char*)[path6 cStringUsingEncoding:1]);
//		int rsi=wavtest((*kdbs),&rrr,(char*)[path cStringUsingEncoding:1],(char*)[urlString cStringUsingEncoding:1],(char*)[path3 cStringUsingEncoding:1],(char*)[path4 cStringUsingEncoding:1],(char*)[path5 cStringUsingEncoding:1],(char*)[path6 cStringUsingEncoding:1]);
				NSString * theValue2 = [NSString stringWithFormat:@"%s",rrr.name];
		//NSString * theValue2 = [NSString stringWithFormat:@"Testing!"];

		
		
	
//		NSString * theValue2 = [NSString stringWithFormat:@"%s",wavtest([path cStringUsingEncoding:1],[urlString cStringUsingEncoding:1],[path3 cStringUsingEncoding:1],[path4 cStringUsingEncoding:1],[path5 cStringUsingEncoding:1],[path6 cStringUsingEncoding:1])];
		
		[actSpinner stopAnimating];
		
		[myLabel setText:theValue2];
		
		[self performSelectorOnMainThread:@selector(newTempMethod:) withObject:theValue2 waitUntilDone:NO];
		
		//-----remove this line for production
		//rrr.start1=0;
		if(rrr.start1!=-1)
		{
		
			//NSString * theValue3 = [NSString stringWithFormat:@"entre 0 e 0 segundos"];
			NSString * theValue3 = [NSString stringWithFormat:@"between %d e %d seconds",(int)round(rrr.start1/100.0),(int)round(rrr.end1/100.0)];
			
			[myLabel2 setText:theValue3];
			
			
			
			NSString * theValue = [NSString stringWithFormat:@"%@ %@ ",theValue2,theValue3];
			[self performSelectorOnMainThread:@selector(newTempMethod:) withObject:theValue waitUntilDone:NO];
			
		}
			//		NSString * theValue4 = [NSString stringWithFormat:@"%d",(int)round(rrr.end1/100.0)];
		
		/*
		if(rrr.start1!=-1)
		{
		  [myLabel2 setText:theValue3];
		  [myLabel3 setText:theValue4];
		
 		  myLabel2.hidden = NO;
		  myLabel3.hidden = NO;
		}*/
		
		time_s=-1;
	}
	else {
		NSString *theValue = [NSString stringWithFormat:@"Listening... %d",time_s];
		[myLabel setText:theValue];
		time_s++;

	}
	
  }
}




- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    mlabel.text=    [arrayNo objectAtIndex:row];
	tmps=[[arrayNo objectAtIndex:row] intValue];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayNo count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayNo objectAtIndex:row];
}

 
 

-(IBAction) play_button_pressed{

	
	
	
	
	
	
	
	
	
	
	/*
	NSString * path = [[NSBundle mainBundle] pathForResource:  @"boostextdescr" ofType: @"txt"];
	NSString * path2 = [[NSBundle mainBundle] pathForResource:  @"1269688143_2" ofType: @"wav"];
	NSString * path3 = [[NSBundle mainBundle] pathForResource:  @"test" ofType: @"keys"];
	NSString * path4 = [[NSBundle mainBundle] pathForResource:  @"emparams" ofType: @"bin"];
	NSString * path5 = [[NSBundle mainBundle] pathForResource:  @"db" ofType: @"fdb"];
	NSString * path6 = [[NSBundle mainBundle] pathForResource:  @"db" ofType: @"kdb"];
	
	//	FILE *f = fopen([path cStringUsingEncoding:1],"r");
	//	if (f == NULL) NSLog([path stringByAppendingString:@" not found"]);
	//	wavtest([path cStringUsingEncoding:1],[path2 cStringUsingEncoding:1],[path3 cStringUsingEncoding:1]);
	//	NSString *theValue = [NSString stringWithFormat:@"%d", test123(100)];

	
	NSString *urlString = [recordedTmpFile path];

	
	
	
	
	search_result rrr;
	int rsi=wavtest(&rrr,[path cStringUsingEncoding:1],[urlString cStringUsingEncoding:1],[path3 cStringUsingEncoding:1],[path4 cStringUsingEncoding:1],[path5 cStringUsingEncoding:1],[path6 cStringUsingEncoding:1]);
	NSString * theValue = [NSString stringWithFormat:@"%s",rrr.name];
	

	
	//	NSString *theValue = [NSString stringWithFormat:@"Done is %d s!",wavtest([path cStringUsingEncoding:1],[urlString cStringUsingEncoding:1],[path3 cStringUsingEncoding:1],[path4 cStringUsingEncoding:1],[path5 cStringUsingEncoding:1],[path6 cStringUsingEncoding:1])];
	///////	NSString *theValue = [NSString stringWithFormat:@"%s",wavtest([path cStringUsingEncoding:1],[urlString cStringUsingEncoding:1],[path3 cStringUsingEncoding:1],[path4 cStringUsingEncoding:1],[path5 cStringUsingEncoding:1],[path6 cStringUsingEncoding:1])];
	[myLabel setText:theValue];
	
	
	
	
	
	
	
	
	
	
	
	
	//The play button was pressed... 
	//Setup the AVAudioPlayer to play the file that we just recorded.
	
	
	//AVAudioPlayer * avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedTmpFile error:&error];
	
//	[avPlayer prepareToPlay];
//	[avPlayer play];
	*/
}




































/*
- (void)InfoViewControllerDidFinish:(InfoViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}*/



-(void)newTempMethod:(NSString*)someText {
	
	
	[delegate record_audio_Controller:self didScanResult:someText];
	
	//[self.delegate myavControllerDidCancel:self];	
}


- (IBAction)showInfo3:(id)sender {
	[self.delegate record_audio_ControllerDidCancel:self];	
}















- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//Clean up the temp file.
	NSFileManager * fm = [NSFileManager defaultManager];
	[fm removeItemAtPath:[recordedTmpFile path] error:&error];
	//Call the dealloc on the remaining objects.
	[recorder dealloc];
	recorder = nil;
	recordedTmpFile = nil;
}


- (void)dealloc {
	[super dealloc];
}

@end
