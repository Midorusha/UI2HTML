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

    //used for init tests
    static NSString *divTag = @"div";
    static NSString *idTag = @"special";

    //used for class tests
    static NSString *classTag1 = @"one";
    static NSString *classTag2 = @"two";
    static NSString *classTag3 = @"three";
    NSString *classesString = [NSString stringWithFormat:@"%@ %@ %@", classTag1, classTag2, classTag3, nil];

    //used for style tests
    static NSString *style1 = @"width:10px;";
    static NSString *style2 = @"padding:0px;";
    static NSString *style3 = @"height:10px;";
    NSDictionary *styleDictionaryA = @{@"width":@"10px",
                                       @"padding":@"0px",
                                       @"height":@"10px"
                                       };
    NSDictionary *styleDictionaryB = @{@"width":@"10px",
                                       @"padding":@"5px 10px 5px 10px",
                                       @"height":@"10px"
                                       };
    NSString *styleString = [NSString stringWithFormat:@"%@%@%@", style1, style2, style3,nil];

    //used for strings tests
    static NSString *beginTagString = @"<div>";
    static NSString *endTagString = @"</div>";
    static NSString *contentString = @"Lorem Ipsum Doloris Sit.";
    NSString *tagWithAttributesString = [NSString stringWithFormat:@"<div id=\"%@\" class=\"%@\" style=\"%@\">", idTag, classesString, styleString];
    NSString *tagWithContent = [NSString stringWithFormat:@"%@%@", tagWithAttributesString, contentString];
    NSString *fullhtml = [NSString stringWithFormat:@"%@%@", tagWithContent, endTagString];

#pragma mark - Init Tests
    qck_describe(@"-init", ^{
        it(@"should contain empty strings", ^{
            tag = [[UI2HTML_Tag alloc] init];
            expect([tag tagString]).to(beEmpty());
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag", ^{
        it(@"should only set tagString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject", ^{
            it(@"should only set tagString", ^{
            //expecting lower case class string without "_UI2HTML"
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class]];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(beEmpty());
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag:class:", ^{
        it(@"should only set tagString and classString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag class:classTag1];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(equal(classTag1));
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject:class:", ^{
        it(@"should only set tagString and classString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class] class:classTag1];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(beEmpty());
            expect([tag classString]).to(equal(classTag1));
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTag:class:id:", ^{
        it(@"should only set tagString, classString, and idString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag class:classTag1 id:idTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(equal(idTag));
            expect([tag classString]).to(equal(classTag1));
            expect([tag inlineStyle]).to(beEmpty());
        });
    });
    qck_describe(@"-initWithTagObject:class:id:", ^{
        it(@"should only set tagString, classString, and idString", ^{
            tag = [[UI2HTML_Tag alloc] initWithTagObject:[Div_UI2HTML class] class:classTag1 id:idTag];
            expect([tag tagString]).to(equal(divTag));
            expect([tag idString]).to(equal(idTag));
            expect([tag classString]).to(equal(classTag1));
            expect([tag inlineStyle]).to(beEmpty());
        });
    });

#pragma mark - Class Tests
        qck_describe(@"-addClasses:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
        });
        it(@"should be empty from nil Array", ^{
            [tag addClasses:nil];
            expect([tag classString]).to(beEmpty());
        });
        it(@"should be empty from empty Array", ^{
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

    qck_describe(@"-clearClasses", ^{
        it(@"should remove all classes", ^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            [tag clearClasses];
            expect([tag classString]).to(beEmpty());
        });
    });

#pragma mark - Style Tests
    qck_describe(@"-addStyles:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
        });
        it(@"should be empty from nil Dictionary", ^{
            [tag addStyles:nil];
            expect([tag inlineStyle]).to(beEmpty());
        });
        it(@"should be empty from empty Dictionary", ^{
            [tag addStyles:@{}];
            expect([tag inlineStyle]).to(beEmpty());
        });
        it(@"should equal one style", ^{
            [tag addStyles:@{@"width":@"10px"}];
            expect([tag inlineStyle]).to(equal(style1));
        });
        it(@"should contain three styles", ^{
            [tag addStyles:styleDictionaryA];
            expect([tag inlineStyle]).to(equal(styleString));
        });
        it(@"should not contain duplicates or update styles", ^{
            [tag addStyles:styleDictionaryA];
            [tag addStyles:styleDictionaryB];
            expect([tag inlineStyle]).to(equal(styleString));
        });
    });

    qck_describe(@"-removeStyle:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addStyles:styleDictionaryA];
        });
        it(@"should not remove style", ^{
            [tag removeStyle:@""];
            expect([tag inlineStyle]).to(equal(styleString));
        });
        it(@"should remove style", ^{
            NSDictionary *bgColor = @{@"background-color":@"green"};
            [tag addStyles:bgColor];
            [tag removeStyle:@"background-color"];
            expect([tag inlineStyle]).to(equal(styleString));
        });
    });

    qck_describe(@"-removeStyles:", ^{
        beforeEach(^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addStyles:styleDictionaryA];
        });
        it(@"should not remove style", ^{
            [tag removeClasses:@[]];
            expect([tag inlineStyle]).to(equal(styleString));
            [tag removeClasses:@[@""]];
            expect([tag inlineStyle]).to(equal(styleString));
        });
        it(@"should remove styles", ^{
            [tag removeStyles:[styleDictionaryA allKeys]];
            expect([tag inlineStyle]).to(beEmpty());
        });
    });

    qck_describe(@"-clearStyles", ^{
        it(@"should remove all styles", ^{
            tag = [[UI2HTML_Tag alloc] init];
            [tag addStyles:styleDictionaryA];
            [tag clearStyles];
            expect([tag inlineStyle]).to(beEmpty());
        });
    });

#pragma mark - String Functions
    qck_describe(@"-beginningTagString", ^{
        it(@"should return beginning tag", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            expect([tag beginTag]).to(equal(beginTagString));
        });
        it(@"should return beginning tag with attributes", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            [tag addStyles:styleDictionaryA];
            [tag setIdString:idTag];
            expect([tag beginTag]).to(equal(tagWithAttributesString));
        });
        it(@"should return closing tag", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            expect([tag endTag]).to(equal(endTagString));
        });
        
        it(@"should return started content", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            [tag addStyles:styleDictionaryA];
            [tag setIdString:idTag];
            expect([tag beginTagWithContent:contentString]).to(equal(tagWithContent));
        });
        
        it(@"should return full html", ^{
            tag = [[UI2HTML_Tag alloc] initWithTag:divTag];
            [tag addClasses:@[classTag1, classTag2, classTag3]];
            [tag addStyles:styleDictionaryA];
            [tag setIdString:idTag];
            expect([tag wrapContentWithTag:contentString]).to(equal(fullhtml));
        });
    });


QuickSpecEnd