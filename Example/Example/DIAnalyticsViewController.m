//
//  DIAnalyticsViewController.m
//  DIAnalytics
//
//  Created by Samuel Cote on 10/31/2016.
//  Copyright (c) 2016 Samuel Cote. All rights reserved.
//

#import "DIAnalyticsViewController.h"

#import "DIAnalytics/DIAnalytics.h"
#import "UIButton+DIButton.h"
#import "IdentifyViewController.h"

@interface DIAnalyticsViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *setTokenButton;
@property (nonatomic, strong) UIButton *identifyButton;

@property (nonatomic, strong) UIView* simulatePushcontent;
@property (nonatomic, strong) UIButton *simulatePushReceptionButton;
@property (nonatomic, strong) UITextField *pushIDTextField;
@property (nonatomic, strong) UIView *secondLine;

@property (nonatomic, strong) UITextView *infoLabel;

@property (nonatomic, strong) UILabel* libraryVersion;

@end

@implementation DIAnalyticsViewController

#define BUTTON_WIDTH 250
#define BUTTON_HEIGHT 44
#define OFFSET 40

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
    [self setTitle:NSLocalizedString(@"DIAnalytics Demo", nil)];
	
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    _contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    
    _setTokenButton = [UIButton diButtonWithType:DIButtonTypeNormal];
    [_setTokenButton setTitle:NSLocalizedString(@"Set Token", nil) forState:UIControlStateNormal];
    [_setTokenButton addTarget:self action:@selector(onClickSetTokenButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.setTokenButton];
    
    _identifyButton = [UIButton diButtonWithType:DIButtonTypeNormal];
    [_identifyButton setTitle:NSLocalizedString(@"Identify", nil) forState:UIControlStateNormal];
    [_identifyButton addTarget:self action:@selector(onClickIdentifyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.identifyButton];
    
    _simulatePushcontent = [[UIView alloc] init];
    _simulatePushcontent.layer.borderColor = [UIColor blackColor].CGColor;
    _simulatePushcontent.layer.borderWidth = 2.0f;
    _simulatePushcontent.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_simulatePushcontent];
    
    _simulatePushReceptionButton = [UIButton diButtonWithType:DIButtonTypeNormal];
    [_simulatePushReceptionButton setTitle:NSLocalizedString(@"Simulate Push Reception", nil) forState:UIControlStateNormal];
    [_simulatePushReceptionButton addTarget:self action:@selector(onClickSimulatePushReceptionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.simulatePushReceptionButton];
    
    _pushIDTextField = [[UITextField alloc] init];
    [_pushIDTextField setPlaceholder:NSLocalizedString(@"Push ID", nil)];
    [_pushIDTextField setTextAlignment:NSTextAlignmentCenter];
    [_pushIDTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.contentView addSubview:self.pushIDTextField];
    
    _secondLine = [[UIView alloc] init];
    [_secondLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.secondLine];

    _infoLabel = [[UITextView alloc] init];
    [_infoLabel setText:NSLocalizedString(@"Working pushID : 12345:a1b2c3d4", nil) ];
    [_infoLabel setTextColor:[UIColor lightGrayColor]];
    [_infoLabel setEditable:NO];
    [_infoLabel setSelectable:YES];
    [_infoLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.infoLabel];
    
    _libraryVersion = [[UILabel alloc] init];
    [_libraryVersion setText:[NSString stringWithFormat:@"Library v%@", [DIAnalytics libraryVersion]]];
    [_libraryVersion setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_libraryVersion];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(removeKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.setTokenButton.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.identifyButton.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.setTokenButton.frame.origin.y +BUTTON_HEIGHT +OFFSET/2, BUTTON_WIDTH, BUTTON_HEIGHT);

    self.simulatePushReceptionButton.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.identifyButton.frame.origin.y +BUTTON_HEIGHT +OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.pushIDTextField.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.simulatePushReceptionButton.frame.origin.y + BUTTON_HEIGHT + 5, BUTTON_WIDTH, BUTTON_HEIGHT);
    self.secondLine.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.pushIDTextField.frame.origin.y +BUTTON_HEIGHT, BUTTON_WIDTH, 1);
    self.infoLabel.frame = CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2, self.secondLine.frame.origin.y +1 +5, BUTTON_WIDTH, BUTTON_HEIGHT);

    self.simulatePushcontent.frame = CGRectMake(self.simulatePushReceptionButton.frame.origin.x - 20, self.simulatePushReceptionButton.frame.origin.y - 20, self.simulatePushReceptionButton.frame.size.width + 40, CGRectGetMaxY(self.infoLabel.frame) - self.simulatePushReceptionButton.frame.origin.y + 20);
    
    self.libraryVersion.frame = CGRectMake(0, CGRectGetMaxY(self.simulatePushcontent.frame) + OFFSET, self.view.frame.size.width, BUTTON_HEIGHT);
    
    self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.libraryVersion.frame.origin.y + self.libraryVersion.frame.size.height + OFFSET);
    _scrollView.contentSize = self.contentView.frame.size;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self deregisterForKeyboardNotifications];
}

#pragma mark - Library Methods

- (void)onClickSetTokenButton {
    [self removeKeyboard];
    
    [DIAnalytics registeForRemoteNotification];
}

- (void)onClickIdentifyButton {
    [self removeKeyboard];

    IdentifyViewController *identifyVC = [[IdentifyViewController alloc] init];
    [self.navigationController pushViewController:identifyVC animated:YES];
}

- (void)onClickSimulatePushReceptionButton {
    [self removeKeyboard];
    
    [DIAnalytics sendPushReception:self.pushIDTextField.text];
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
    [self.pushIDTextField resignFirstResponder];
}

@end
