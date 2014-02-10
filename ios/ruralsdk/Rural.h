//
//  Rural.h
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rural : NSObject

@property (nonatomic,retain) NSString* ruralHost;
@property (nonatomic,retain) NSString* appId;


- (void) apnsRegisteredWithToken:(NSData*)deviceId;

@end
