//
//  UITextView+LimitInput.m
//  Input
//
//  Created by mac on 2021/2/5.
//  Copyright © 2021 apple. All rights reserved.
//

#import "UITextView+LimitInput.h"
#import <objc/runtime.h>
#import "NSString+LimitInput.h"
static char UITextViewAvailableCharacterSetKey;
static char UITextViewIsAvailableBlockKey;
@implementation UITextView (LimitInput)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodExchange];
    });
}
-(AvailableCharacterSet)availableCharacterSet{
    return [objc_getAssociatedObject(self, &UITextViewAvailableCharacterSetKey) integerValue];
}
-(void)setAvailableCharacterSet:(AvailableCharacterSet)availableCharacterSet{
    objc_setAssociatedObject(self, &UITextViewAvailableCharacterSetKey, @(availableCharacterSet), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+(void)methodExchange{
    SEL textViewSEL = NSSelectorFromString(@"keyboardInput:shouldInsertText:isMarkedText:");
    if ([UITextField.new respondsToSelector:textViewSEL] == NO) {
        return;
    }
    Method textViewMethod = class_getInstanceMethod(UITextView.class, textViewSEL);
    Method exTextViewMethod = class_getInstanceMethod([self class], @selector(ex_keyboardInput:shouldInsertText:isMarkedText:));
    method_exchangeImplementations(textViewMethod, exTextViewMethod);
}

-(BOOL (^)(NSString *, BOOL))isAvailableBlock{
    return objc_getAssociatedObject(self, &UITextViewIsAvailableBlockKey);
}
-(void)setIsAvailableBlock:(BOOL (^)(NSString *, BOOL))isAvailableBlock{
    objc_setAssociatedObject(self, &UITextViewIsAvailableBlockKey, isAvailableBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(BOOL)ex_keyboardInput:(id)object shouldInsertText:(NSString*)text isMarkedText:(BOOL)isMarkedText{
    BOOL result = [self ex_keyboardInput:object shouldInsertText:text isMarkedText:isMarkedText];
    if (result == YES && self.availableCharacterSet != AvailableCharacterSetAll) {
        result = [text isValidWithAvailableCharacterSet:self.availableCharacterSet];
        if (self.isAvailableBlock) {
            return self.isAvailableBlock(text,result);
        }
        return result;
    }
    return result;
}
@end
