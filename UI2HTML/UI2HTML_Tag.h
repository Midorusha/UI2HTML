//
//  UI2HTML_Tag.h
//  UI2HTML
//
//  Created by Christopher Davis on 7/26/15.
//  Copyright (c) 2015 Christopher Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UI2HTML_Tag : NSObject


@property(nonatomic, copy, nonnull) NSString *tagString;
@property(nonatomic, copy, nullable) NSString *idString;
@property(nonatomic, copy, nullable) NSString *classString;
@property(nonatomic, copy, nullable) NSMutableString *customStyle;

//Initializer for tag
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject;

//Inintializer for tag and class
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString Class:(nullable NSString *)classString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject Class:(nullable NSString *)classString;

//Initializer for tag, class, and id
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString Class:(nullable NSString *) classString Id:(nullable NSString *)idString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject Class:(nullable NSString *) classString Id:(nullable NSString *)idString;

//Set, Add, and Remove Styles.
//Can take mixed arrays of type NSString * or id.
- (void)setClasses:(nullable NSArray *)classesArray;
- (void)setStyles:(nullable NSDictionary *)stylesArray;

//Only adds Classes and styles if not found
//must remove Style and readd to edit
//get your margins and paddings right
- (void)addClasses:(nullable NSArray *)classesArray;
- (void)addStyles:(nullable NSDictionary *)stylesArray;

- (void)removeClass:(nonnull NSString *)classToRemove;
- (void)removeStyle:(nonnull NSString *)styleToRemove;

- (void)removeClasses:(nonnull NSArray *)classesToRemove;
- (void)removeStyles:(nonnull NSDictionary *)stylesToRemove;


//Creates <tag id="special" class="baseTag" style="margin:0;">
- (nonnull NSString *)beginningTagString;
//Creates </tag>
- (nonnull NSString *)closingTagString;

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster</tag>
//used internally for wrapContentWithTag, but there might be other uses for it later
- (nonnull NSMutableString *)beginningTagStringWithContent:(nullable NSString *)content;

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster</tag>
- (nonnull NSString *)wrapContentWithTag:(nonnull NSString *)content;

+ (void)appendIfNotFound:(nonnull NSMutableString *)searchString String:(nonnull NSString *)string;
+ (void)appendIfNotFound:(nonnull NSMutableString *)searchString SubString:(nonnull NSString *)subString String:(nonnull NSString *)string;
+ (NSUInteger)removeFromString:(nonnull NSMutableString *)searchString
                  InsertString:(nonnull NSString *)insertString
                         Start:(nonnull NSString *)startString
                           End:(nonnull NSString *)endString;
                                                                                                 
@end
