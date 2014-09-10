//
//  main.m
//  Assignment 2
//
//  Created by hoangminh on 9/7/14.
//  Copyright (c) 2014 Minh Vu Hoang Nguyen. All rights reserved.

//  Name: Minh Nguyen
//  Student ID: 892335290
//  CPSC 411
//  MW 1:00 PM - 2:15 PM

#import <Foundation/Foundation.h>

// Convert to lowercase
NSString *ConvertToLowercase(NSString *myString);

// break word into letters
NSMutableArray *BreakWordIntoCharaters(NSString *word);

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        NSDate *functionStart = [NSDate date];
        
        /* Start timing....*/
        
        NSStringEncoding *encoding;
        NSError *error;
        
        // keep track number of anagrams
        NSInteger count = 0;
        
        // set the new line charater
        NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
        // set the data for the file words
        
        NSString *data = [NSString stringWithContentsOfFile:@"/Users/hoangminh/Desktop/CPSC411/AnagramFinder/AnagramFinder/words" usedEncoding:encoding error:&error];
        
        // read file into array
        NSMutableArray *myStr = [[data componentsSeparatedByCharactersInSet:newlineCharSet] mutableCopy];
        
        
        NSCountedSet *anagramCount = [[NSCountedSet alloc] init];
        
        for(int i = 0; i < [myStr count]; i++)
        {
            // convert word to lowercase
            myStr[i] = ConvertToLowercase(myStr[i]);
            
            // break word into letters
            NSMutableArray *c = BreakWordIntoCharaters(myStr[i]);
            // sort individual word
            NSArray *sorted = [c sortedArrayUsingSelector:@selector(compare:)];
            // join all the sorted individual word
            NSString *newStr = [sorted componentsJoinedByString:@""];
            // add each sorted individual word into the anagramCount array
            [anagramCount addObject:newStr];
        }
        
        for(id item in anagramCount)
        {
            if([anagramCount countForObject:item] > count)
            {
                count = [anagramCount countForObject:item];
                NSLog(@"The word %@ has the largetst set of anagrams with number of anagrams is %li", item, count);
            }
        }
        
        NSDate *functionFinish = [NSDate date];
        NSTimeInterval executionTime = [functionFinish timeIntervalSinceDate:functionStart];
        
        /* Finish */
        
        // Display how long it would take to execute the function
        NSLog(@"Execution Time = %f", executionTime);
        
    }
    return 0;
}

// Convert to lowercase
NSString *ConvertToLowercase(NSString *myString)
{
    return myString.lowercaseString;
}


// break word into letters
NSMutableArray *BreakWordIntoCharaters(NSString *word)
{
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[word length]];
    
    for (int i = 0; i < [word length]; i++)
    {
        NSString *iChar = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
        [characters addObject: iChar];
    }
    
    return characters;
}
