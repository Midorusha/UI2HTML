//
//  UI2HTML_Tag.m
//  UI2HTML
//
//  Created by Christopher Davis on 7/26/15.
//  Copyright (c) 2015 Christopher Davis. All rights reserved.
//

#import "UI2HTML_Tag.h"

#define NILCAPACITYCHECK(container) if(nil == container || ![container count]) return

//TODO should i make all NSString setters to do NSSTRING copy?
@implementation UI2HTML_Tag

#pragma mark -Constructors
-(instancetype)init {
    if(self = [super init]) {
        self.tagString   = @"";
        self.idString    = @"";
        self.classString = @"";
        self.customStyle = [[NSMutableString alloc] init];
    }
    return self;
}

- (instancetype)initWithTag:(NSString *)tagString {
    if(self = [self init]) {
        self.tagString   = tagString;
    }
    return self;
}

- (instancetype)initWithTagObject:(id)tagObject {
    if(self = [super init]) {
        NSMutableString * tmp = [[NSMutableString alloc] initWithString:NSStringFromClass([tagObject class])];
        [tmp replaceOccurrencesOfString:@"_UI2HTML"
                             withString:@""
                                options:0
                                  range:NSMakeRange(0, [tmp length])];
        self.tagString = [tmp lowercaseString];
    }
    return self;
}



- (instancetype)initWithTag:(NSString *)tagString class:(NSString *)classString {
    if(self = [self initWithTag:tagString]) {
        self.classString = classString;
    }
    return self;
}

- (instancetype)initWithTagObject:(id)tagObject class:(NSString *)classString {
    if(self = [self initWithTagObject:tagObject]) {
        self.classString = classString;
    }
    return self;
}



- (instancetype)initWithTag:(NSString *)tagString class:(NSString *) classString id:(NSString *)idString {
    if(self = [self initWithTag:tagString class:classString]) {
        self.idString = idString;
    }
    return self;
}

- (instancetype)initWithTagObject:(id)tagObject class:(NSString *) classString id:(NSString *)idString {
    if(self = [self initWithTagObject:tagObject class:classString]) {
        self.idString = idString;
    }
    return self;
}



#pragma mark -Setters
- (void)setClasses:(NSArray *)classesArray {
    NILCAPACITYCHECK(classesArray);
    __block NSMutableString *classListString = [[NSMutableString alloc] init];
    [classesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[NSString class]] && [(NSString *)obj length]) {
            [classListString appendString:obj];
        }
        else if(obj) {
            //null id instances will print (nil). We don't want that.
            [classListString appendString:NSStringFromClass([obj class])];
        }
        if([classListString length]) [classListString appendString:@" "];
    }];
    if([classListString length]) [self setClassString:classListString];
}

//TODO: This needs huge testing with everything, need to make sure obj gets translated properly
- (void)setStyles:(NSDictionary *)stylesArray {
    NILCAPACITYCHECK(stylesArray);
    __block NSMutableString *styleListString = [[NSMutableString alloc] init];
    [stylesArray enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([NSNull null] != obj) {
            [styleListString appendFormat:@"%@:%@;", key, obj, nil];
        }
    }];
    if([styleListString length]) [self setCustomStyle:styleListString];
}


- (void)addClasses:(NSArray *)classesArray {
    NILCAPACITYCHECK(classesArray);
    __block NSMutableString *tmpClassString = [[NSMutableString alloc] initWithString:[self classString]];
    [classesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[NSString class]] && [(NSString *)obj length]) {
            [UI2HTML_Tag appendIfNotFound:tmpClassString string:obj];
        }
        else if([NSNull null] != obj) {
            //null id instances will print (nil). We don't want that.
            [UI2HTML_Tag appendIfNotFound:tmpClassString string:NSStringFromClass([obj class])];
        }
        if([tmpClassString length]) [tmpClassString appendString:@" "];
    }];
    if([tmpClassString length]) [self setClassString:tmpClassString];
}

// TODO: Same testing issue here only adds styles if not found
- (void)addStyles:(nullable NSDictionary *)stylesArray {
    NILCAPACITYCHECK(stylesArray);
    __block NSMutableString *tmpStyleListString = [[NSMutableString alloc] initWithString:[self customStyle]];
    [stylesArray enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([NSNull null] != obj) {
            [UI2HTML_Tag appendIfNotFound:tmpStyleListString subString:key string:[NSString stringWithFormat:@"%@:%@;", key, obj, nil]];
            [tmpStyleListString appendFormat:@"%@:%@;", key, obj, nil];
        }
    }];
    if([tmpStyleListString length]) [self setCustomStyle:tmpStyleListString];
}

- (void)removeClass:(NSString *)classToRemove {
    NSMutableString *tmpClassString = [NSMutableString stringWithString:[self classString]];
    NSUInteger timesReplaced = [tmpClassString replaceOccurrencesOfString:classToRemove
                                    withString:@""
                                       options:0
                                         range:NSMakeRange(0, [tmpClassString length])];
    if(timesReplaced) [self setClassString:tmpClassString];
}

- (void)removeStyle:(NSString *)styleToRemove {
    NSMutableString *tmpStyleString = [NSMutableString stringWithString:[self customStyle]];
    NSUInteger timesRemoved = [UI2HTML_Tag removeFromString:tmpStyleString
                     insertString:@""
                            start:styleToRemove
                              end:@";"];
    if(timesRemoved) [self setCustomStyle:tmpStyleString];
}

// TODO: need to trim string to get rid of multiple white spaces
- (void)removeClasses:(NSArray *)classesToRemove {
    NILCAPACITYCHECK(classesToRemove);
    __block NSMutableString *tmpClassString = [[NSMutableString alloc] initWithString:[self classString]];
    [classesToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([NSNull null] != obj) {
            NSString *findString = ([obj isKindOfClass:[NSString class]]) ? obj : NSStringFromClass([obj class]);
            [tmpClassString replaceOccurrencesOfString:findString
                                            withString:@""
                                               options:0
                                                 range:NSMakeRange(0, [tmpClassString length])];
        }
    }];
    if([tmpClassString length]) [self setClassString:tmpClassString];
}

- (void)removeStyles:(NSDictionary *)stylesToRemove {
    NILCAPACITYCHECK(stylesToRemove);
    __block NSMutableString *tmpStyleListString = [[NSMutableString alloc] initWithString:[self customStyle]];
    [stylesToRemove enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([NSNull null] != obj) {
            [UI2HTML_Tag removeFromString:tmpStyleListString
                             insertString:@""
                                    start:key
                                      end:@";"];
        }
    }];
    if([tmpStyleListString length]) [self setCustomStyle:tmpStyleListString];
}


#pragma mark - String Operators
//Creates <tag id="special" class="baseTag" style="margin:0;">
- (NSString *)beginningTagString {
    NSMutableString *beginString = [[NSMutableString alloc] initWithFormat:@"<%@", [self tagString], nil];
    if([[self idString] length])    [beginString appendFormat:@"id=\"%@\"", [self idString], nil];
    if([[self classString] length]) [beginString appendFormat:@"class=\"%@\"", [self classString], nil];
    if([[self customStyle] length]) [beginString appendFormat:@"style=\"%@\"", [self customStyle], nil];
    [beginString appendString:@">"];
    return beginString;
}

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster
- (NSMutableString *)beginningTagStringWithContent:(NSString *)content {
    NSAssert([content length], @"Content should not be null");
    NSMutableString *beginString = [[NSMutableString alloc] initWithFormat:@"<%@", [self tagString], nil];
    if([[self idString] length])    [beginString appendFormat:@"id=\"%@\"", [self idString], nil];
    if([[self classString] length]) [beginString appendFormat:@"class=\"%@\"", [self classString], nil];
    if([[self customStyle] length]) [beginString appendFormat:@"style=\"%@\"", [self customStyle], nil];
    [beginString appendFormat:@">%@", content, nil];
    return beginString;
}

//Creates </tag>
- (NSString *)closingTagString {
    return [[NSString alloc] initWithFormat:@"</%@>", [self tagString], nil];
}

//Creates <tag id="special" class="baseTag" style="margin:0;">Content Here Slightly faster</tag>
- (NSString *)wrapContentWithTag:(NSString *)content {
    NSMutableString *wrappingContentString = [self beginningTagStringWithContent:content];
    [wrappingContentString appendString:[self closingTagString]];
    return wrappingContentString;
}


#pragma mark - Utilities
+ (void)appendIfNotFound:(NSMutableString *)searchString string:(NSString *)string {
    if(![searchString containsString:string]) [searchString appendString:string];
}

+ (void)appendIfNotFound:(NSMutableString *)searchString subString:(NSString *)subString string:(NSString *)string {
    if(![searchString containsString:subString]) [searchString appendString:string];
}

//Over Kill, reuse for remove and replace, but redo this to do a simple look up
+ (NSUInteger)removeFromString:(NSMutableString *)searchString
                  insertString:(NSString *)insertString
                   start:(NSString *)startString
                     end:(NSString *)endString {
    NSError *error = NULL;
    NSString *findString = [NSString stringWithFormat:@"%@.*?%@", startString, endString, nil];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:findString
                                                                           options:0
                                                                             error:&error];
    return [regex replaceMatchesInString:searchString options:0 range:NSMakeRange(0, [searchString length]) withTemplate:findString];
}

@end
