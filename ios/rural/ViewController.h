//
//  ViewController.h
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PushEditView.h"


@interface ViewController : UIViewController <PushEditDelegate>

@property (nonatomic,retain) IBOutlet PushEditView* pushView;

@end
