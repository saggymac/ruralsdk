//
//  TextViewNext.h
//  rural
//
//  Created by Scott Guyer on 2/7/14.
//  Copyright (c) 2014 Scott Guyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewNext : UITextView <UITextViewDelegate>
{
    
}

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end