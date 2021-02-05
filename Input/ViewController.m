//
//  ViewController.m
//  Input
//
//  Created by apple on 4/2/2021.
//  Copyright © 2021 apple. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+LimitInput.h"
#import "UITextView+LimitInput.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textField = UITextField.new;
    CGFloat y = 50;
    textField.frame = CGRectMake(5, y, 200, 30);
    textField.layer.borderColor = UIColor.redColor.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.availableCharacterSet = AvailableCharacterSetLowerCaseLetters;
    [self.view addSubview:textField];
    
    y += 50;
    textField = UITextField.new;
    textField.frame = CGRectMake(5, y, 200, 30);
    textField.layer.borderColor = UIColor.redColor.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.availableCharacterSet = AvailableCharacterSetUpperCaseLetter;
    [self.view addSubview:textField];
    
    y += 50;
    textField = UITextField.new;
    textField.frame = CGRectMake(5, y, 200, 30);
    textField.layer.borderColor = UIColor.redColor.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.availableCharacterSet = AvailableCharacterSetEnglishPunctuation;
    [self.view addSubview:textField];
    
    y += 50;
    textField = UITextField.new;
    textField.frame = CGRectMake(5, y, 200, 30);
    textField.layer.borderColor = UIColor.redColor.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.availableCharacterSet = AvailableCharacterSetNumber;
    [self.view addSubview:textField];
    
    y += 50;
    textField = UITextField.new;
    textField.frame = CGRectMake(5, y, 200, 30);
    textField.layer.borderColor = UIColor.redColor.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.availableCharacterSet =
    AvailableCharacterSetLowerCaseLetters|AvailableCharacterSetUpperCaseLetter|
    AvailableCharacterSetNumber|AvailableCharacterSetEnglishPunctuation;
    [self.view addSubview:textField];
    
    UITextView *textView = UITextView.new;
    textView.layer.borderColor = UIColor.redColor.CGColor;
    textView.layer.borderWidth = 1.0f;    textView.availableCharacterSet = AvailableCharacterSetNumber|AvailableCharacterSetEnglishPunctuation;
    textView.frame = CGRectMake(5, y, 200, 300);
    [self.view addSubview:textView];
}
@end
