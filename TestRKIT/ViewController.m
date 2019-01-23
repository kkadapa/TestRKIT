//
//  ViewController.m
//  TestRKIT
//
//  Created by Kadapa, Krishna Karthik on 11/9/17.
//  Copyright © 2017 Northwell Health. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ORKTaskViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)taskViewController:(ORKTaskViewController *)taskViewController
       didFinishWithReason:(ORKTaskViewControllerFinishReason)reason
                     error:(NSError *)error {
    
    switch (reason) {
            
        case ORKTaskViewControllerFinishReasonCompleted:{
            
            ORKTaskResult *taskResult = [taskViewController result];
            // You could do something with the result here.
            
               NSLog(@"taskResult is %@",taskResult);
            
                NSLog(@"%ld",(long)reason);
            
            break;
        }         
    
        case ORKTaskViewControllerFinishReasonFailed:
        case ORKTaskViewControllerFinishReasonDiscarded:
            
            NSLog(@"discarded...");
            
            break;
    }
    
    // Then, dismiss the task view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewDidAppear:(BOOL)animated {

    ORKInstructionStep *step =
    [[ORKInstructionStep alloc] initWithIdentifier:@"identifier"];
    step.title = @"Selection Survey";
    step.text = @"This survey helps us understand your eligibility for the fitness study";
    
    NSArray *textChoices =
    @[
      [ORKTextChoice choiceWithText:@"None" value:@"1"],
      [ORKTextChoice choiceWithText:@"Mild" value:@"2"],       
      [ORKTextChoice choiceWithText:@"Moderate" value:@"3"],
      [ORKTextChoice choiceWithText:@"Severe" value:@"4"],
      [ORKTextChoice choiceWithText:@"Very Severe" value:@"5"]
      ];
    
    ORKAnswerFormat *answerFormat = [ORKAnswerFormat choiceAnswerFormatWithStyle:ORKChoiceAnswerStyleSingleChoice
                                                    textChoices:textChoices];
    
    ORKQuestionStep *choiceQ = [ORKQuestionStep questionStepWithIdentifier:@"stepidentifier" title:@"How severe is your dry mouth ?" answer:answerFormat];
    
    
    ORKQuestionStep *choiceQ1 = [ORKQuestionStep questionStepWithIdentifier:@"stepidentifier1" title:@"How difficult is it for you to swallow ?" answer:answerFormat];
    
    ORKOrderedTask *task =
    [[ORKOrderedTask alloc] initWithIdentifier:@"task" steps:@[step,choiceQ,choiceQ1]];
    
    ORKTaskViewController *taskViewController =
    [[ORKTaskViewController alloc] initWithTask:task taskRunUUID:nil];
    taskViewController.delegate = self;
    
    [self presentViewController:taskViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
