//
//  NSString+LimitInput.m
//  Input
//
//  Created by mac on 2021/2/5.
//  Copyright © 2021 apple. All rights reserved.
//

#import "NSString+LimitInput.h"
static NSSet* lowerCaseLetters(){
    static NSSet *_lowerCaseLetters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *lowerCaseLetters = @[
            @"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p",
            @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l",
            @"z", @"x", @"c", @"v", @"b", @"n", @"m"];
        _lowerCaseLetters = [NSSet setWithArray:lowerCaseLetters];
        
    });
    return _lowerCaseLetters;
}

static NSSet* upperCaseLetter(){
    static NSSet *_upperCaseLetter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *upperCaseLetter = @[
            @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P",
            @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L",
            @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
        _upperCaseLetter = [NSSet setWithArray:upperCaseLetter];
        
    });
    return _upperCaseLetter;
}

static NSSet* number(){
    static NSSet *_number = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *number = @[
            @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"
        ];
        _number = [NSSet setWithArray:number];
    });
    return _number;
}

static NSSet* decimalPad(){
    static NSSet *_decimalPad = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *mu_decimalPad = NSMutableArray.new;
        [mu_decimalPad addObject:number().allObjects];
        [mu_decimalPad addObject:@"."];
        NSArray *decimalPad = mu_decimalPad;
        _decimalPad = [NSSet setWithArray:decimalPad];
    });
    return _decimalPad;;
}

static NSSet* englishPunctuation(){
    static NSSet *_englishPunctuation = nil;
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
        _englishPunctuation = [NSSet setWithArray:englishPunctuation];
    });
    return _englishPunctuation;
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
    NSMutableSet *muset = NSMutableSet.new;
    if (set&AvailableCharacterSetLowerCaseLetters){
        [muset addObjectsFromArray:lowerCaseLetters().allObjects];
    }
    if (set&AvailableCharacterSetUpperCaseLetter){
        [muset addObjectsFromArray:upperCaseLetter().allObjects];
    }
    if (set&AvailableCharacterSetNumber){
        [muset addObjectsFromArray:number().allObjects];
    }
    if (set&AvailableCharacterSetDecimalPad) {
        [muset addObjectsFromArray:decimalPad().allObjects];
    }
    if (set&AvailableCharacterSetEnglishPunctuation){
        [muset addObjectsFromArray:englishPunctuation().allObjects];
    }
    NSString *exp = [NSString stringWithFormat:@"[%@]*",[[muset allObjects] componentsJoinedByString:@""]];
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
