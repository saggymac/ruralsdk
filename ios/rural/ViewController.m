//
//  ViewController.m
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import "ViewController.h"
#import "RuralClient.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.pushView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark PushEditDelegate

- (void) pushView:(PushEditView*)view sendActionWithText:(NSString*)msg
{
    RuralClient* client = [[RuralClient alloc] init];
    [client sendPushMessage:msg];
}

@end
