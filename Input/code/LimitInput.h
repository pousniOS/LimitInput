//
//  LimitInput.h
//  NavigationBar
//
//  Created by mac on 2021/2/4.
//

#ifndef LimitInput_h
#define LimitInput_h

typedef NS_OPTIONS(NSUInteger, AvailableCharacterSet) {
    AvailableCharacterSetAll                = 0,   //所有字符
    AvailableCharacterSetLowerCaseLetters   = 1<<0,//小写字母 [a-z]
    AvailableCharacterSetUpperCaseLetter    = 1<<1,//大写字母 [A-Z]
    AvailableCharacterSetNumber             = 1<<2,//数字 [0-9]
    AvailableCharacterSetDecimalPad         = 1<<3,//带小数点的数字
    AvailableCharacterSetEnglishPunctuation = 1<<4,//英文标点符号
};

#endif /* LimitInput_h */
