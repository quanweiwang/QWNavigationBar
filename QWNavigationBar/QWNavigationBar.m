//
//  QWNavigationBar.m
//  QWNavigationBar
//
//  Created by 王权伟 on 2018/11/4.
//  Copyright © 2018 王权伟. All rights reserved.
//

#import "QWNavigationBar.h"
#import <objc/runtime.h>

@implementation QWNavigationBar

- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar {
    self = [super initWithFrame:navigationBar.frame];
    
    if (self) {
        
    }
    
    return self;
}

- (NSDictionary *)properties_aps {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([UINavigationBar class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (propertyValue) {
            [self setValue:propertyValue forKey:propertyName];
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    
    return props;
    
}

@end

