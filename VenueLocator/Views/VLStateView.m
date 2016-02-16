//
//  VLStateView.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLStateView.h"

@implementation VLStateView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.alpha = 0.0f;
    self.layer.cornerRadius = 12.0f;
    self.layer.borderWidth = 4.0f;
    self.layer.borderColor = [self borderColorForState:VLStateViewStateNone];
}

- (void)setState:(VLStateViewState)state {
    if (self.state != state) {
        _state = state;
        
        self.layer.borderColor = [self borderColorForState:state];
        
        __block VLStateView *blockSelf = self;
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             blockSelf.alpha = [blockSelf alphaForState:state];
                             
                         }
                         completion:nil];
    }
}

- (CGColorRef)borderColorForState:(VLStateViewState)state {
    switch (state) {
        case VLStateViewStateError:
            return [UIColor redColor].CGColor;
        case VLStateViewStateEmpty:
            return [UIColor yellowColor].CGColor;
        case VLStateViewStateLoading:
            return [UIColor yellowColor].CGColor;
        default:
            return [UIColor clearColor].CGColor;
            break;
    }
}

- (CGFloat)alphaForState:(VLStateViewState)state {
    return VLStateViewStateNone == state ? 0.0f : 1.0f;
}

@end
