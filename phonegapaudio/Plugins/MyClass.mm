#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "record_audio_testViewController.h"
#import "MyClass.h" 


  
@implementation MyClass 

@synthesize successCallback, failCallback;


@synthesize callbackID;

- (void) scan:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{	
	
	
	NSUInteger argc = [arguments count];
	
	
	
	self.callbackID = [arguments pop];
	
	
	NSLog(@"cid --> %@\n",self.callbackID);
	
	
	argc = [arguments count];
	
	printf("arguments %d\n",argc);
	NSLog(@"--> %@\n",[arguments objectAtIndex:0]);
	
	
	
	
	
	record_audio_testViewController *widgetController = [[record_audio_testViewController alloc] initWithNibName:@"record_audio_testViewController" bundle:[NSBundle mainBundle]];

	widgetController.delegate = self;
	widgetController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

	
	
	[[super appViewController]	presentModalViewController:widgetController animated:YES];

	
	[widgetController release];
	

	
}


- (void)record_audio_ControllerDidCancel:(record_audio_testViewController*)controller {
	
	
	printf("cancel\n");
	[[super appViewController ]  dismissModalViewControllerAnimated:YES];
}


- (void)record_audio_Controller:(record_audio_testViewController*)controller didScanResult:(NSString *)result {
	
	
	printf("DidScanResult\n");
	
	
	
	
	NSLog(@"cid --> %@\n",self.callbackID);
	
	
	
	NSString* jsCallBack = [NSString stringWithFormat:@"dotest(\"%@\");", [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
	[self writeJavascript: jsCallBack];

	
	
	
	
}


- (void)dealloc {
    [[super appViewController] dealloc];
}


@end