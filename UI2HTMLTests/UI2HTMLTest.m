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

@interface Div_UI2HTML : NSObject
@end
@implementation Div_UI2HTML
@end

/*
 * Notes: Html Tags are insensitive
 */
QuickSpecBegin(UI2HTML_TagSpec)

    __block UI2HTML_Tag * tag;
    static NSString *divTag = @"div";
    static NSString *idTag = @"special";
    static NSString *classTag1 = @"one";
    static NSString *classTag2 = @"two";
    static NSString *classTag3 = @"three";
    NSString *classesString = [NSString stringWithFormat:@"%@ %@ %@", classTag1, classTag2, classTag3, nil];

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
            expect([tag classString]).to(equal(classesString));
            
        });
    });

    //TODO: look up behave like
    qck_describe(@"-addClasses:", ^{
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
            NSString *checkString = [NSString stringWithFormat:@"%@ %@", classTag1, classTag2, nil];
            expect([tag classString]).to(equal(checkString));
            
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            expect([tag classString]).to(equal(classesString));
        });
    });

    qck_describe(@"-removeClass:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
        });
        it(@"should not remove class", ^{
            [tag removeClass:@""];
            expect([tag classString]).to(equal(classesString));
        });
        it(@"should remove first class", ^{
            [tag removeClass:classTag1];
            NSString *checkString = [NSString stringWithFormat:@"%@ %@", classTag2, classTag3, nil];
            expect([tag classString]).to(equal(checkString));
        });
        it(@"should remove middle class", ^{
            [tag removeClass:classTag2];
            NSString *checkString = [NSString stringWithFormat:@"%@ %@", classTag1, classTag3, nil];
            expect([tag classString]).to(equal(checkString));
        });
        it(@"should remove last class", ^{
            [tag removeClass:classTag3];
            NSString *checkString = [NSString stringWithFormat:@"%@ %@", classTag1, classTag2, nil];
            expect([tag classString]).to(equal(checkString));
        });
    });
        
    qck_describe(@"-removeClasses:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
        });
        it(@"should not remove classes", ^{
            [tag removeClasses:@[]];
            expect([tag classString]).to(equal(classesString));
            [tag removeClasses:@[@""]];
            expect([tag classString]).to(equal(classesString));
        });
        it(@"should remove two classes", ^{
            [tag removeClasses:@[classTag1, classTag3]];
            expect([tag classString]).to(equal(classTag2));
        });
    });

QuickSpecEnd