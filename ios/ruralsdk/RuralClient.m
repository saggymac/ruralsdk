//
//  RuralClient.m
//  rural
//
//  Created by Scott Guyer on 2/8/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import "RuralClient.h"

@implementation RuralClient

- (void) sendPushMessage:(NSString*)msg
{
    NSString* url = [NSString stringWithFormat:@"%@/pushraw", self.ruralHost];
    NSMutableURLRequest* req  = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSString* escaped = [msg stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString* jsonBody = [NSString stringWithFormat:@"{\"aps\":{\"alert\":\"%@\"}}", escaped];
    NSData* data = [jsonBody dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:data];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:req queue:nil completionHandler:
     ^(NSURLResponse* resp, NSData* data, NSError* err) {
         NSHTTPURLResponse* httpResp = (NSHTTPURLResponse*)resp;
         if ( err != nil )
         {
             NSLog( @"unable to send push: %@", err);
         }
         else if ( httpResp.statusCode != 200 )
         {
             NSLog( @"error while sending push; status %d", httpResp.statusCode);
         }
     }];

}

@end
