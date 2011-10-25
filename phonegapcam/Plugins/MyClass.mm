
//
//  MyClass.m
//   
// Created by Nimish Nayak on 08/08/2011. 
// Copyright 2011 Nimish Nayak. All rights reserved.


#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "MyAVController.h"
#import "MyClass.h" 


  
@implementation MyClass 

@synthesize successCallback, failCallback;


@synthesize callbackID;

- (void) scan:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{	
	
	
	NSUInteger argc = [arguments count];
	
	printf("arguments %d\n",argc);
	
	
	
	self.callbackID = [arguments pop];
	
	
	NSLog(@"cid --> %@\n",self.callbackID);
	
	
	argc = [arguments count];
	
	printf("arguments %d\n",argc);
	NSLog(@"--> %@\n",[arguments objectAtIndex:0]);
	
	
	
	
	/*
	if (argc < 1) {
		return;	
	}
	self.successCallback = [arguments objectAtIndex:0];
	if (argc > 1) {
		self.failCallback = [arguments objectAtIndex:1];	
	}
	
	//NSString* aaa = @"aaa"; 
	//NSString* jsCallBack = [NSString stringWithFormat:@"%@(\"%@\");", self.successCallback, aaa ];
	
	
	NSLog(@"--> %@\n",[arguments objectAtIndex:0]);
	NSLog(@"--> %@\n",[arguments objectAtIndex:1]);

	
	
	NSLog(@"success %@\n",self.successCallback);
	//NSLog("success %@\n",jsCallBack);
	//[self writeJavascript: jsCallBack];
	
	*/
	
	MyAVController *widgetController = [[MyAVController alloc] initWithDelegate:self];

	widgetController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	
	[[super appViewController]	presentModalViewController:widgetController animated:YES];

	
	[widgetController release];
	

	
}


- (void)myavControllerDidCancel:(MyAVController*)controller {
//	[self writeJavascript: [NSString stringWithFormat:@"%@();", self.failCallback]];

	
	printf("cancel\n");
	[[super appViewController ]  dismissModalViewControllerAnimated:YES];
}


- (void)myavController:(MyAVController*)controller didScanResult:(NSString *)result {
	
	
	printf("DidScanResult\n");
	//: %@\n",result);

	
	
	NSLog(@"cid --> %@\n",self.callbackID);
	
//	NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];  
	//NSMutableString *stringToReturn = [NSMutableString stringWithString: @"Javascript:"];
//	[stringToReturn appendString: stringObtainedFromJavascript];
//	[stringToReturn appendString: result];
	
	//PluginResult* pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsString:                     [stringToReturn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//[self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
	
	NSString* jsCallBack = [NSString stringWithFormat:@"dotest(\"%@\");", [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
	[self writeJavascript: jsCallBack];

	
	//[[super appViewController ]  dismissModalViewControllerAnimated:YES];
	
	
}


- (void)dealloc {
    [[super appViewController] dealloc];
}


@end