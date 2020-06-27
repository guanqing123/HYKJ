//
//  KJPasswordLoginView.m
//  HYKJ
//
//  Created by information on 2020/6/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJPasswordLoginView.h"

@interface KJPasswordLoginView()

@property (nonatomic, weak) UITextField *khdmTextField;
@property (nonatomic, weak) UIView  *firstLine;

@property (nonatomic, weak) UITextField *passwordTextField;
@property (nonatomic, weak) UIView  *secondLine;
@property (nonatomic, weak) UIButton *passwordButton;

@property (nonatomic, weak) UIButton *submitButton;

@end

@implementation KJPasswordLoginView

#pragma mark - init
+ (instancetype)passwordView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.backgroundColor = [UIColor whiteColor];
     
     UITextField *khdmTextField = [[UITextField alloc] init];
     [khdmTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
     khdmTextField.placeholder = @"请输入客户代码";
     _khdmTextField = khdmTextField;
     [self addSubview:khdmTextField];
     
     UIView *firstLine = [[UIView alloc] init];
     firstLine.backgroundColor = RGB(223, 223, 223);
     _firstLine = firstLine;
     [self addSubview:firstLine];
     
     UITextField *passwordTextField = [[UITextField alloc] init];
     passwordTextField.placeholder = @"请输入密码";
     passwordTextField.secureTextEntry = YES;
     [passwordTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
     _passwordTextField = passwordTextField;
     [self addSubview:passwordTextField];
     
     UIView *secondLine = [[UIView alloc] init];
     secondLine.backgroundColor = RGB(223, 223, 223);
     _secondLine = secondLine;
     [self addSubview:secondLine];
     
     UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
     [passwordButton addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
     _passwordButton = passwordButton;
     [self addSubview:passwordButton];
     
     UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [submitButton setTitle:@"登录" forState:UIControlStateNormal];
     submitButton.layer.cornerRadius = 8;
     submitButton.layer.masksToBounds = YES;
     submitButton.backgroundColor = RGB(207, 235, 221);
     [submitButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
     submitButton.userInteractionEnabled = NO;
     _submitButton = submitButton;
     [self addSubview:submitButton];
}

- (void)contentChanged {
    if (self.khdmTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.submitButton.userInteractionEnabled = YES;
        self.submitButton.backgroundColor = KJColor;
    }else{
        self.submitButton.userInteractionEnabled = NO;
        self.submitButton.backgroundColor = RGB(207, 235, 221);
    }
    self.loginParam.khdm = self.khdmTextField.text;
    self.loginParam.password = self.passwordTextField.text;
}

- (void)showPassword:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self.passwordButton setImage:[UIImage imageNamed:@"open_eye"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = NO;
    }else{
        [self.passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = YES;
    }
}

- (void)login {
    // 1.退出键盘
    [self.khdmTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    // 2.代理回调
    if ([self.delegate respondsToSelector:@selector(passwordLoginViewDidLogin:)]) {
        [self.delegate passwordLoginViewDidLogin:self];
    }
}

#pragma mark - layout
- (void)updateConstraints {
    // 1.constraints
    [self.khdmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self).offset(45);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.khdmTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.khdmTextField.mas_bottom).offset(25);
        make.left.equalTo(self.khdmTextField);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 32);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.passwordTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    
    [self.passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.khdmTextField.mas_bottom).offset(30);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
        make.width.mas_equalTo(ScreenW - 45 * 2);
        make.height.mas_equalTo(44);
        make.left.equalTo(self).offset(45);
    }];
    
    // 2.更新
    [super updateConstraints];
}

#pragma mark - model
- (KJLoginParam *)loginParam {
    if (!_loginParam) {
        _loginParam = [[KJLoginParam alloc] init];
        _loginParam.loginid = @"admin";
    }
    return _loginParam;
}


@end
