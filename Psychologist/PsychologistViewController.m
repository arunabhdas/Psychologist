//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by  on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()

@property (nonatomic) int diagnosis;



@end

@implementation PsychologistViewController

@synthesize  diagnosis = _diagnosis;

- (void) setAndShowDiagnosis:(int) diagnosis
{
	self.diagnosis = diagnosis;
	[self performSegueWithIdentifier:@"ShowDiagnosisSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowDiagnosisSegue"])
	{
		[segue.destinationViewController setHappiness:self.diagnosis];
	}
	else if ([segue.identifier isEqualToString:@"CelebritySegue"])
	{
		[segue.destinationViewController setHappiness:100];
	}
	else if ([segue.identifier isEqualToString:@"SeriousSegue"])
	{
		[segue.destinationViewController setHappiness:20];
	}
	else if ([segue.identifier isEqualToString:@"TVSegue"])
	{
		[segue.destinationViewController setHappiness:50];
	}
}

- (IBAction)flying 
{
	[self setAndShowDiagnosis:85];
}
- (IBAction)apple 
{
	[self setAndShowDiagnosis:100];
}

- (IBAction)dragons 
{
	[self setAndShowDiagnosis:20];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
