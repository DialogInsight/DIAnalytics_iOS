//
//  IdentifyViewController.m
//  DIAnalytics
//
//  Created by William-José Simard-Touzet on 2016-11-08.
//  Copyright © 2016 Samuel Cote. All rights reserved.
//

#import "IdentifyViewController.h"
#import "UIButton+DIButton.h"
#import "DIAnalytics/DIAnalytics.h"

@interface IdentifyViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UIView *emailLine;
@property (nonatomic, strong) UITextField *firstNameTextField;
@property (nonatomic, strong) UIView *firstNameLine;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *nameLine;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UITextView *infoLabel;

@end

@implementation IdentifyViewController

#define BUTTON_WIDTH 250
#define BUTTON_HEIGHT 44
#define OFFSET 20

#pragma mark - life cycle

- (id)init {
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"DIAnalytics Demo - Identify", nil)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    _contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    
    _emailTextField = [[UITextField alloc] init];
    [_emailTextField setPlaceholder:NSLocalizedString(@"Email", nil)];
    [_emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [_emailTextField setTextAlignment:NSTextAlignmentCenter];
    [_emailTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_emailTextField setReturnKeyType:UIReturnKeyNext];
    [_emailTextField setDelegate:self];
    [self.contentView addSubview:self.emailTextField];
    
    _emailLine = [[UIView alloc] init];
    [_emailLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.emailLine];

    _firstNameTextField = [[UITextField alloc] init];
    [_firstNameTextField setPlaceholder:NSLocalizedString(@"First Name", nil)];
    [_firstNameTextField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [_firstNameTextField setTextAlignment:NSTextAlignmentCenter];
    [_firstNameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_firstNameTextField setReturnKeyType:UIReturnKeyNext];
    [_firstNameTextField setDelegate:self];
    [self.contentView addSubview:self.firstNameTextField];
    
    _firstNameLine = [[UIView alloc] init];
    [_firstNameLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.firstNameLine];
    
    _nameTextField = [[UITextField alloc] init];
    [_nameTextField setPlaceholder:NSLocalizedString(@"Last Name", nil)];
    [_nameTextField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [_nameTextField setTextAlignment:NSTextAlignmentCenter];
    [_nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_nameTextField setReturnKeyType:UIReturnKeyDefault];
    [_nameTextField setDelegate:self];
    [self.contentView addSubview:self.nameTextField];
    
    _nameLine = [[UIView alloc] init];
    [_nameLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.nameLine];
    
    _submitButton = [UIButton diButtonWithType:DIButtonTypeNormal];
    [_submitButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(onClickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.submitButton];
    
    _infoLabel = [[UITextView alloc] init];
    [_infoLabel setText:NSLocalizedString(@"Working email : jgrichard@dialoginsight.com", nil) ];
    [_infoLabel setTextColor:[UIColor lightGrayColor]];
    [_infoLabel setEditable:NO];
    [_infoLabel setSelectable:YES];
    [self.contentView addSubview:self.infoLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(removeKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.emailTextField.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.emailLine.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.emailTextField.frame.origin.y + BUTTON_HEIGHT, BUTTON_WIDTH, 1);
    
    self.firstNameTextField.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.emailLine.frame.origin.y + 1 + OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.firstNameLine.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.firstNameTextField.frame.origin.y + BUTTON_HEIGHT, BUTTON_WIDTH, 1);
    
    self.nameTextField.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.firstNameLine.frame.origin.y + 1 + OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.nameLine.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.nameTextField.frame.origin.y + BUTTON_HEIGHT, BUTTON_WIDTH, 1);
    
    self.submitButton.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.nameLine.frame.origin.y + 1 + OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    
    self.infoLabel.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.submitButton.frame.origin.y + BUTTON_HEIGHT + OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    
    self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.infoLabel.frame.origin.y + self.infoLabel.frame.size.height+20);
    self.scrollView.contentSize = self.contentView.frame.size;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self deregisterForKeyboardNotifications];
}

#pragma mark - UITextFieldDelegate 

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.firstNameTextField becomeFirstResponder];
        [textField resignFirstResponder];
    }
    else if (textField == self.firstNameTextField) {
        [self.nameTextField becomeFirstResponder];
        [textField resignFirstResponder];
    }
    else if (textField == self.nameTextField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - User Interaction

- (void)onClickSubmitButton {
    if ([self isValid]) {
        NSMutableDictionary *customFieldsDictionary = [[NSMutableDictionary alloc] init];
        [customFieldsDictionary setObject:self.emailTextField.text forKey:@"f_EMail"];
        [customFieldsDictionary setObject:self.firstNameTextField.text forKey:@"first_name"];
        [customFieldsDictionary setObject:self.nameTextField.text forKey:@"name"];
        NSDictionary *contactDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:customFieldsDictionary, @"contact", nil];
        
        [DIAnalytics identify:contactDictionary];
    
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Identify", nil) message:NSLocalizedString(@"Email field cannot be empty.", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Private Methods

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterForKeyboardNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+5, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)removeKeyboard {
    if ([self.emailTextField isFirstResponder]) [self.emailTextField resignFirstResponder];
    else if ([self.firstNameTextField isFirstResponder]) [self.firstNameTextField resignFirstResponder];
    else if ([self.nameTextField isFirstResponder]) [self.nameTextField resignFirstResponder];
}

- (BOOL)isValid {
    BOOL isValid = YES;
    if ([self.emailTextField.text isEqualToString:@""]) isValid = NO;
    
    return isValid;
}

@end
