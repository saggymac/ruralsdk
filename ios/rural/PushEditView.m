//
//  PushEditView.m
//  rural
//
//  Created by Scott Guyer on 2/6/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import "PushEditView.h"
#import "TextViewNext.h"

@interface PushEditView ()

@property (nonatomic,retain) TextViewNext* alertText;
@property (nonatomic,retain) UITextField* badgeInput;
@property (nonatomic,retain) UIButton* sendButton;

@end


@implementation PushEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self makeSubviews];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        [self makeSubviews];
    }
    
    return self;
}




- (void) handleTap:(UITapGestureRecognizer*)sender
{
    if ( sender.view == self )
        [self.alertText resignFirstResponder];
}


- (void) handleSendButton:(id)sender
{
    if ( self.delegate != nil )
        [self.delegate pushView:self sendActionWithText:self.alertText.text];
}

- (void) makeSubviews
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.];
    
    CGRect f = CGRectZero;
    
    f.size.height = self.frame.size.height / 2.;
    f.size.width = self.frame.size.width;
    self.alertText = [[TextViewNext alloc] initWithFrame:f];
    [self.alertText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.alertText setPlaceholder:@"alert text"];
    [self addSubview:self.alertText];
    
//    self.badgeInput = [[UITextField alloc] initWithFrame:
//                       CGRectMake(0, f.size.height, 48, 40)];
//    [self.badgeInput setUserInteractionEnabled:NO];
//    [self addSubview:self.badgeInput];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sendButton addTarget:self action:@selector(handleSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.sendButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sendButton];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
}


- (void) updateConstraints
{
    if ( self.alertText != nil )
    {
        NSDictionary* views = @{
                                @"alertText" : self.alertText,
//                                @"badgeInput" : self.badgeInput,
                                @"sendButton" : self.sendButton
                                };
        
        
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[alertText(>=30,<=150)]-[sendButton(==30)]-20-|" options:0 metrics:nil views:views];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[alertText(>=100)]-20-|" options:0 metrics:nil views:views];
        [self addConstraints:constraints];
        
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[sendButton]-|" options:0 metrics:nil views:views];
        [self addConstraints:constraints];
    }
    
    [super updateConstraints];
    
}

@end
