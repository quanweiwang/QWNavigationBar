//
//  UIViewController+QWNavigationBar.m
//  QWNavigationBar
//
//  Created by 王权伟 on 2018/11/4.
//  Copyright © 2018 王权伟. All rights reserved.
//

#import "UIViewController+QWNavigationBar.h"
#import "QWNavigationBar.h"
#import <objc/runtime.h>

@interface UIViewController (QWNavigationBar)
@property (nonatomic, strong) UINavigationBar * customNavigationBar;
@end

@implementation UIViewController (QWNavigationBar)

static void swizzleMethod(SEL originalSel, SEL replacedSel){
    
    //获取类名
    Class class = NSClassFromString(@"UIViewController");
    
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method swizzledMethod = class_getInstanceMethod(class, replacedSel);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            replacedSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(@selector(viewDidLoad),
                      @selector(qw_viewDidLoad));
        swizzleMethod(@selector(viewWillAppear:),
                      @selector(qw_viewWillAppear:));
        swizzleMethod(@selector(viewWillDisappear:),
                      @selector(qw_viewWillDisappear:));
        swizzleMethod(@selector(viewWillLayoutSubviews),
                      @selector(qw_viewWillLayoutSubviews));
        swizzleMethod(@selector(viewDidAppear:),
                      @selector(qw_viewDidAppear:));
    });
}

- (void)qw_viewDidLoad {
    [self qw_viewDidLoad];
}

- (void)qw_viewWillAppear:(BOOL)animated {
    [self qw_viewWillAppear:animated];
}

- (void)qw_viewWillDisappear:(BOOL)animated {
    
    [self qw_viewWillDisappear:animated];
}

- (void)qw_viewDidAppear:(BOOL)animated {
    
    [self.customNavigationBar removeFromSuperview];
    NSLog(@"%@",self.customNavigationBar);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self qw_viewDidAppear:animated];
}

- (void)qw_viewWillLayoutSubviews {
    
    UINavigationBar * navigationBar = self.navigationController.navigationBar;

    if (navigationBar != nil && self.customNavigationBar == nil) {
        self.customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        self.customNavigationBar.items = navigationBar.items;
        [self.view addSubview:self.customNavigationBar];
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }

    [self qw_viewWillLayoutSubviews];
}

- (void)setCustomNavigationBar:(UINavigationBar *)customNavigationBar {
    objc_setAssociatedObject(self, "customNavigationBar", customNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)customNavigationBar {
    return objc_getAssociatedObject(self, "customNavigationBar");
}

@end
