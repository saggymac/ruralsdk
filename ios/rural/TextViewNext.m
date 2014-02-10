#import "TextViewNext.h"

@interface TextViewNext ()

@property (nonatomic, retain) UIColor* savedTextColor;

@end

@implementation TextViewNext



- (void) commonInit
{
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];

    [self setDelegate:self];
}


- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self commonInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [super initWithCoder:aDecoder] )
    {
        [self commonInit];
    }
    
    return self;
}



- (void) setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    NSString* content = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( content==nil || content.length <= 0 )
    {
        self.savedTextColor = self.textColor;
        self.textColor = self.placeholderColor;
        self.text = _placeholder;
    }

}



#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ( [self.text isEqualToString:self.placeholder] )
    {
        self.text = @"";
        self.textColor = self.savedTextColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSString* content = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( content==nil || content.length <= 0 )
    {
        self.savedTextColor = self.textColor;
        self.textColor = self.placeholderColor;
        self.text = self.placeholder;
    }
    
}




@end
