//
//  NSString+LimitInput.m
//  Input
//
//  Created by mac on 2021/2/5.
//  Copyright © 2021 apple. All rights reserved.
//

#import "NSString+LimitInput.h"
static NSString* lowerCaseLetters(){
    static NSString *_lowerCaseLetters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *lowerCaseLetters = @[
            @"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p",
            @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l",
            @"z", @"x", @"c", @"v", @"b", @"n", @"m"];
        _lowerCaseLetters = [lowerCaseLetters componentsJoinedByString:@""];
        
    });
    return _lowerCaseLetters;
}

static NSString* upperCaseLetter(){
    static NSString *_upperCaseLetter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *upperCaseLetter = @[
            @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P",
            @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L",
            @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
        _upperCaseLetter = [upperCaseLetter componentsJoinedByString:@""];
        
    });
    return _upperCaseLetter;
}

static NSString* number(){
    static NSString *_number = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *number = @[
            @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"
        ];
        _number = [number componentsJoinedByString:@""];
    });
    return _number;
}

static NSString* englishPunctuation(){
    static NSString *_englishPunctuation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *englishPunctuation = @[
            @"`",
            @"~" ,
            @"!",
            @"@",
            @"#",
            @"$",
            @"%",
            @"^",
            @"&" ,
            @"*",
            @"(",
            @")",
            @"_" ,
            @"\\-",
            @"+",
            @"=",
            @"\\{",
            @"}",
            @"\\[",
            @"\\]",
            @"\\\\",
            @"|",
            @"<" ,
            @">" ,
            @",",
            @".",
            @"/",
            @"?",
            @";",
            @":",
            @"'",
            @"\"",
            @" ",
            @"\\n"
        ];
        _englishPunctuation = [englishPunctuation componentsJoinedByString:@""];
    });
    return _englishPunctuation;
}

static NSString* otherPunctuation(){
    static NSString *_otherPunctuation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *otherPunctuation = @[
        ];
        _otherPunctuation = [otherPunctuation componentsJoinedByString:@""];
    });
    return _otherPunctuation;
}

static NSPredicate *getPredicateWithCharacterSet(AvailableCharacterSet set){

    static NSMutableDictionary<NSNumber*,NSPredicate*> *_inputLimitPredicates = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _inputLimitPredicates = NSMutableDictionary.new;
    });
    
    NSPredicate *predicate = _inputLimitPredicates[@(set)];
    if (predicate) {
        return predicate;
    }
    if (set == AvailableCharacterSetAll) {
        return nil;
    }
    NSString *chars = @"";
    if (set&AvailableCharacterSetLowerCaseLetters){
        chars = [chars stringByAppendingString:lowerCaseLetters()];
    }
    if (set&AvailableCharacterSetUpperCaseLetter){
        chars = [chars stringByAppendingString:upperCaseLetter()];
    }
    if (set&AvailableCharacterSetNumber){
        chars = [chars stringByAppendingString:number()];
    }
    if (set&AvailableCharacterSetEnglishPunctuation){
        chars = [chars stringByAppendingString:englishPunctuation()];
    }
    if (set&AvailableCharacterSetOtherPunctuation){
        chars = [chars stringByAppendingString:otherPunctuation()];
    }
    NSString *exp = [NSString stringWithFormat:@"[%@]*",chars];
    _inputLimitPredicates[@(set)] = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",exp];
    return _inputLimitPredicates[@(set)];
}

@implementation NSString (LimitInput)
-(BOOL)isValidWithAvailableCharacterSet:(AvailableCharacterSet)set{
    if (set == AvailableCharacterSetAll) {
        return YES;
    }
    return [getPredicateWithCharacterSet(set) evaluateWithObject:self];
}
@end
