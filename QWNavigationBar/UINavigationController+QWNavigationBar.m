//
//  UINavigationController+QWNavigationBar.m
//  QWNavigationBar
//
//  Created by 王权伟 on 2018/11/4.
//  Copyright © 2018 王权伟. All rights reserved.
//

#import "UINavigationController+QWNavigationBar.h"
#import "QWNavigationBar.h"
#import <objc/runtime.h>

@implementation UINavigationController (QWNavigationBar)

static void swizzleMethod(SEL originalSel, SEL replacedSel){
    
    //获取类名
    Class class = NSClassFromString(@"UINavigationController");
    
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
        swizzleMethod(@selector(pushViewController:animated:),
                      @selector(qw_pushViewController:animated:));
        swizzleMethod(@selector(popViewControllerAnimated:),
                      @selector(qw_popViewControllerAnimated:));
        swizzleMethod(@selector(popToRootViewControllerAnimated:),
                      @selector(qw_popToRootViewControllerAnimated:));
        swizzleMethod(@selector(popToViewController:animated:),
                      @selector(qw_popToViewController:animated:));
    });
}

- (void)qw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIViewController * visibleViewController = self.visibleViewController;
    
    UINavigationBar * navigationBar = visibleViewController.navigationController.navigationBar;
    
    UINavigationBar * customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    customNavigationBar.items = navigationBar.items;
    [visibleViewController.view addSubview:customNavigationBar];
    
    [self setNavigationBarHidden:YES animated:NO];
    
    [self qw_pushViewController:viewController animated:animated];
}

- (UIViewController *)qw_popViewControllerAnimated:(BOOL)animated {

    return [self qw_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)qw_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {

    return [self qw_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)qw_popToRootViewControllerAnimated:(BOOL)animated {

    return [self qw_popToRootViewControllerAnimated:animated];
}

@end
