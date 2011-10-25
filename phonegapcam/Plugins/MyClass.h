
//
//  MyClass.h
//
//  Created by Nimish Nayak on 08/08/2011. 
//  Copyright 2011 Nimish Nayak. All rights reserved.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#ifdef PHONEGAP_FRAMEWORK
#import <PhoneGap/PGPlugin.h>
#else
#import "PGPlugin.h"
#endif

#import "MyAVController.h"


@interface MyClass : PGPlugin <MyAVDelegate> {
    
	
	NSString* callbackID;
	NSString* successCallback;
	NSString* failCallback;
}


@property (nonatomic, copy) NSString* callbackID;

@property (nonatomic, copy) NSString* successCallback;
@property (nonatomic, copy) NSString* failCallback;



//Instance Method  

- (void) scan:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end