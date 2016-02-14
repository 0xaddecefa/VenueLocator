//
//  VLIcon.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLIcon.h"

@interface VLIcon()

@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;

@end

@implementation VLIcon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.prefix = DYNAMIC_CAST(dictionary[@"prefix"], NSString);
        self.suffix = DYNAMIC_CAST(dictionary[@"suffix"], NSString);
    }
    return self;
}

- (NSURL *)urlForSize:(VLIconSize)iconSize andWithBackground:(BOOL)withBackground {
    
    if (self.prefix && self.suffix) {
        NSString *urlString = nil;
        if (withBackground) {
            urlString = [NSString stringWithFormat:@"%@%@%@%@",
                         self.prefix,
                         @"bg_",
                         @(iconSize),
                         self.suffix];
        } else {
            urlString = [NSString stringWithFormat:@"%@%@%@",
                         self.prefix,
                         @(iconSize),
                         self.suffix];
            
        }
        
        if (urlString) {
            return [NSURL URLWithString:urlString];
        }
    }
    
    return nil;
}


@end
