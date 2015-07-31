//
//  UI2HTMLTest.m
//  UI2HTML
//
//  Created by Christopher Davis on 7/26/15.
//  Copyright (c) 2015 Christopher Davis. All rights reserved.
//

//second floor chicago althletic association

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>
@import Nimble;
#import "UI2HTML_Tag.h"

static NSString *divTag = @"div";
static NSString *idTag = @"special";
static NSString *classTag1 = @"one";
static NSString *classTag2 = @"two";
static NSString *classTag3 = @"three";

@interface Div_UI2HTML : NSObject
@end
@implementation Div_UI2HTML
@end

/*
 * Notes: Html Tags are insensitive
 */
QuickSpecBegin(UI2HTML_TagSpec)
__block UI2HTML_Tag * tag;
    qck_describe(@"-init", ^{
        it(@"should contain empty strings", ^{
            tag = [[UI2HTML_Tag alloc] init];
            expect([tag tagString]).to(beNil());
            expect([tag idString]).to(beNil());
            expect([tag classString]).to(beNil());
            expect([tag customStyle]).to(beNil());
        });
    });
    qck_describe(@"-initWithTag", ^{
        it(@"should only set tagString with String", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beNil());
            expect([tag classString]).to(beNil());
            expect([tag customStyle]).to(beNil());
        });
    });
    qck_describe(@"-initWithTagObject", ^{
            it(@"should only set tagString with Class", ^{
            //expecting lower case class string without "_UI2HTML"
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beNil());
            expect([tag classString]).to(beNil());
            expect([tag customStyle]).to(beNil());
        });
    });
    qck_describe(@"-initWithTag:Class:", ^{
        it(@"should only set tagString with Class", ^{
            //expecting lower case class string without "_UI2HTML"
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beNil());
            expect([tag classString]).to(beNil());
            expect([tag customStyle]).to(beNil());
        });
    });
qck_describe(@"-initWithTagObject", ^{
    it(@"should only set tagString with Class", ^{
        //expecting lower case class string without "_UI2HTML"
        tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
        expect([tag tagString]).to(equal(divTag));
        expect([tag idString]).to(beNil());
        expect([tag classString]).to(beNil());
        expect([tag customStyle]).to(beNil());
    });
});qck_describe(@"-initWithTagObject", ^{
    it(@"should only set tagString with Class", ^{
        //expecting lower case class string without "_UI2HTML"
        tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
        expect([tag tagString]).to(equal(divTag));
        expect([tag idString]).to(beNil());
        expect([tag classString]).to(beNil());
        expect([tag customStyle]).to(beNil());
    });
});

QuickSpecEnd