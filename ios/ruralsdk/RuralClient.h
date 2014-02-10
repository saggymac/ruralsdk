//
//  RuralClient.h
//  rural
//
//  Created by Scott Guyer on 2/8/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import "Rural.h"


//
// This is meant as just a little helper for sending push messages
// Don't intend to include it in the sdk. Used by test apps.
//
@interface RuralClient : Rural

- (void) sendPushMessage:(NSString*)msg;

@end
