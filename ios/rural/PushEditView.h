//
//  PushEditView.h
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PushEditView;


@protocol PushEditDelegate <NSObject>

- (void) pushView:(PushEditView*)view sendActionWithText:(NSString*)msg;

@end


@interface PushEditView : UIView

@property (nonatomic,assign) id<PushEditDelegate> delegate;

@end
