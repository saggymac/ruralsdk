//
//  Rural.m
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import "Rural.h"
#import <UIKit/UIDevice.h>



static NSString* _configFileName = @"RuralConfig";


@interface Rural ()


@end




@implementation Rural

-(id)init
{
    self = [super init];
    if ( self )
    {
        [self loadConfig];
    }
    
    return self;
}


- (void) loadConfig
{
    
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:_configFileName ofType:@"plist"];
    
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    NSString *error;
    NSPropertyListFormat format;
    id plist;
    
    plist = [NSPropertyListSerialization propertyListFromData:plistData
                                             mutabilityOption:NSPropertyListImmutable
                                                       format:&format
                                             errorDescription:&error];
    if ( (plist == nil) || (! [plist isKindOfClass:[NSDictionary class]]) )
    {
        NSLog(@"%s: %@", __FUNCTION__, error);
        return;
    }
    
    
    NSDictionary* configData = (NSDictionary*)plist;
    
    
    // Will want to refactor this out once we get more configurable properties
    
    id val = [configData objectForKey:@"ruralHost"];
    if( val && [val isKindOfClass:[NSString class]] )
        self.ruralHost = val;
    else
        self.ruralHost = @"api.rural.com";
    
    val = [configData objectForKey:@"ruralAppId"];
    if ( val && [val isKindOfClass:[NSString class]] )
        self.appId = val;
    else
        self.appId = nil;
}


- (BOOL) configIsValid
{
    // todo: check to make sure we have valid config data
    return YES;
}

- (NSString*) stringFromDeviceData:(NSData*)data
{
    NSString* result = nil;
    
    if ( [data respondsToSelector:@selector(base64EncodedStringWithOptions:)] )
        result = [data performSelector:@selector(base64EncodedDataWithOptions:) withObject:nil];
    else
        result = [data performSelector:@selector(base64Encoding)];
    
    return result;
}


- (NSString*) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
}




- (NSString *)urlEncodeWithString: (NSString*)string
{
    CFStringRef urlString = CFURLCreateStringByAddingPercentEscapes(
                                                                    NULL,
                                                                    (CFStringRef)string,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                    kCFStringEncodingUTF8 );
    return (NSString *)CFBridgingRelease(urlString);
}



- (void) apnsRegisteredWithToken:(NSData*)deviceId
{
    if ( ! [self configIsValid] )
        return;
    
    NSString* devId = [self stringFromDeviceData:deviceId];
    NSString* ver = [self appVersion];
    
    NSString* formEncoded = [NSString stringWithFormat:@"appId=%@&deviceId=%@&appVersion=%@",
                             self.appId, devId, ver];
    
    NSString* url = [NSString stringWithFormat:@"%@/register", self.ruralHost];
    NSMutableURLRequest* req  = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[formEncoded dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [NSURLConnection sendAsynchronousRequest:req queue:nil completionHandler:
     ^(NSURLResponse* resp, NSData* data, NSError* err) {
         NSHTTPURLResponse* httpResp = (NSHTTPURLResponse*)resp;
         if ( err != nil )
         {
             NSLog( @"unable to register device: %@", err);
         }
         else if ( httpResp.statusCode != 200 )
         {
             NSLog( @"error while registering; status %d", httpResp.statusCode);
         }
     }];
}

@end
