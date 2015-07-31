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
            expect([tag tagString]).to(beEmpty());
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag", ^{
        it(@"should only set tagString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject", ^{
            it(@"should only set tagString", ^{
            //expecting lower case class string without "_UI2HTML"
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag:class:", ^{
        it(@"should only set tagString and classString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag class:classTag1];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(equal(classTag1));
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject:class:", ^{
        it(@"should only set tagString and classString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class] class:classTag1];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(equal(classTag1));
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag:class:id:", ^{
        it(@"should only set tagString, classString, and idString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag class:classTag1 id:idTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(equal(idTag));
            expect([tag classString]).to(equal(classTag1));
            expect([tag customStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject:class:id:", ^{
        it(@"should only set tagString, classString, and idString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class] class:classTag1 id:idTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(equal(idTag));
            expect([tag classString]).to(equal(classTag1));
            expect([tag customStyle]).to(beEmpty());
        });
    });

    qck_describe(@"-setClasses:", ^{
        __block UI2HTML_Tag *tag = nil;
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
        });
        it(@"should be nil from nil Array", ^{
            [tag setClasses:nil];
            expect([tag classString]).to(beEmpty());
        });
        it(@"should be nil from empty Array", ^{
            [tag setClasses:@[]];
            expect([tag classString]).to(beEmpty());
        });
        it(@"should equal one class", ^{
            [tag setClasses:@[classTag1]];
            expect([tag classString]).to(equal(classTag1));
        });
        it(@"should contain two classes", ^{
            [tag setClasses:@[classTag1, classTag2]];
            expect([tag classString]).to(contain(classTag1));
            expect([tag classString]).to(contain(classTag2));
        });
        it(@"should not contain duplicate classes", ^{
            [tag setClasses:@[classTag1, classTag2]];
            [tag setClasses:@[classTag1, classTag2, classTag3]];
            expect([tag classString]).to(contain(classTag1));
            expect([tag classString]).to(contain(classTag2));
        });
    });

    //TODO: look up behave like
    qck_describe(@"-addClasses:", ^{
        __block UI2HTML_Tag *tag = nil;
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
        });
        it(@"should be nil from nil Array", ^{
            [tag addClasses:nil];
            expect([tag classString]).to(beEmpty());
        });
        it(@"should be nil from empty Array", ^{
            [tag addClasses:@[]];
            expect([tag classString]).to(beEmpty());
        });
        it(@"should equal one class", ^{
            [tag addClasses:@[classTag1]];
            expect([tag classString]).to(equal(classTag1));
        });
        it(@"should contain two classes", ^{
            [tag addClasses:@[classTag1, classTag2]];
            expect([tag classString]).to(contain(classTag1));
            expect([tag classString]).to(contain(classTag2));
        });
        it(@"should not contain duplicate classes", ^{
            [tag addClasses:@[classTag1, classTag2]];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            expect([tag classString]).to(contain(classTag1));
            expect([tag classString]).to(contain(classTag2));
        });
    });

QuickSpecEnd