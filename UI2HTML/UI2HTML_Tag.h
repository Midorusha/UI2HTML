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
@property(nonatomic, copy, nullable) NSMutableString *inlineStyle;

//Initializer with empty strings
- (nullable instancetype)init;

//Initializer for tag
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject;

//Inintializer for tag and class
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString class:(nullable NSString *)classString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject class:(nullable NSString *)classString;

//Initializer for tag, class, and id
- (nullable instancetype)initWithTag:(nonnull NSString *)tagString class:(nullable NSString *)classString id:(nullable NSString *)idString;
- (nullable instancetype)initWithTagObject:(nonnull id)tagObject class:(nullable NSString *)classString id:(nullable NSString *)idString;


//Only adds Classes and styles if not found
//must remove Style and readd to edit
//get your margins and paddings right
- (void)addClasses:(nullable NSArray *)classesArray;
- (void)addStyles:(nullable NSDictionary *)stylesArray;

- (void)removeClass:(nonnull NSString *)classToRemove;
- (void)removeStyle:(nonnull NSString *)styleToRemove;

- (void)removeClasses:(nonnull NSArray *)classesToRemove;
- (void)removeStyles:(nonnull NSArray *)stylesToRemove;

- (void)clearClasses;
- (void)clearStyles;

//Creates <tag id="special" class="baseTag" style="margin:0;">
- (nonnull NSString *)beginTag;
//Creates </tag>
- (nonnull NSString *)endTag;

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster</tag>
//used internally for wrapContentWithTag, but there might be other uses for it later
- (nonnull NSMutableString *)beginTagWithContent:(nullable NSString *)content;

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster</tag>
- (nonnull NSString *)wrapContentWithTag:(nonnull NSString *)content;

@end
