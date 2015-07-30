//
//  UI2HTMLTest.m
//  UI2HTML
//
//  Created by Christopher Davis on 7/26/15.
//  Copyright (c) 2015 Christopher Davis. All rights reserved.
//

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>
@import Nimble;
#import "UI2HTML_Tag.h"

QuickSpecBegin(UI2HTML_TagSpec)
    qck_describe(@"A Tag", ^{
        __block UI2HTML_Tag *tag = nil;
        qck_beforeEach(^{
            tag = [UI2HTML_Tag new];
        });
        it(@"addClasses", ^{
            [tag addClasses:nil];
            expect(@(1+1)).to(equal(@2));
        });
    });

QuickSpecEnd