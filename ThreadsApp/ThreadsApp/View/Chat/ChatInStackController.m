//
//  ChatInStackController.m
//  ThreadsApp
//
//  Created by Brooma Service on 04/09/2018.
//  Copyright © 2018 Brooma Service. All rights reserved.
//

#import "ChatInStackController.h"
#import <Threads/Threads.h>

@interface ChatInStackController ()
@property (weak, nonatomic) IBOutlet UIView *chatContainer;

@end

@implementation ChatInStackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Threads showInView: self.chatContainer
       parentController: self];

    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
