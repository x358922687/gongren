//
//  NSStringAdditions.m
//  TestFont
//
//  Created by yhj on 13-4-10.
//  Copyright (c) 2013年 yhj. All rights reserved.
//

#import "NSStringAdditions.h"

@implementation NSString (Extends)



+ (NSString *)stringSaveDotTwoBit:(double)price
{
    float price1 = ((int)(price*100 + 0.5))/100.0;
    NSString *str = [NSString stringWithFormat:@"%@",@(price1)];
    NSUInteger docLoc = [str rangeOfString:@"."].location;
    if (docLoc != NSNotFound)
    {
        if (str.length - docLoc > 3)
        {
            str = [str substringToIndex:docLoc + 3];
        }
    }
    return str;
}

- (BOOL)isWhitespaceAndNewlines
{
	NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < self.length; ++i)
    {
		unichar c = [self characterAtIndex:i];
		if (![whitespace characterIsMember:c])
        {
			return NO;
		}
	}
	return YES;
}

- (BOOL)isEmptyOrWhitespace
{
	return !self.length ||
	![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

+ (NSString *)removeWhitespace:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return string;
}

// Copied and pasted from http://www.mail-archive.com/cocoa-dev@lists.apple.com/msg28175.html
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding
{
	NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
	NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
	NSScanner* scanner = [[NSScanner alloc] initWithString:self];
	while (![scanner isAtEnd])
    {
		NSString* pairString = nil;
		[scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
		[scanner scanCharactersFromSet:delimiterSet intoString:NULL];
		NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
		if (kvPair.count == 2)
        {
			NSString* key = [[kvPair objectAtIndex:0]
							 stringByReplacingPercentEscapesUsingEncoding:encoding];
			NSString* value = [[kvPair objectAtIndex:1]
							   stringByReplacingPercentEscapesUsingEncoding:encoding];
			[pairs setObject:value forKey:key];
		}
	}
	
	return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query
{
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [query keyEnumerator])
    {
		NSString* value = [query objectForKey:key];
		value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
		value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
	
	NSString* params = [pairs componentsJoinedByString:@"&"];
	if ([self rangeOfString:@"?"].location == NSNotFound)
    {
		return [self stringByAppendingFormat:@"?%@", params];
	}
    else
    {
		return [self stringByAppendingFormat:@"&%@", params];
	}
}

- (NSComparisonResult)versionStringCompare:(NSString *)other
{
	NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
	NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
	
	// The parts before the "a"
	NSString *oneMain = [oneComponents objectAtIndex:0];
	NSString *twoMain = [twoComponents objectAtIndex:0];
	
	// If main parts are different, return that result, regardless of alpha part
	NSComparisonResult mainDiff;
	if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame)
    {
		return mainDiff;
	}
	
	// At this point the main parts are the same; just deal with alpha stuff
	// If one has an alpha part and the other doesn't, the one without is newer
	if ([oneComponents count] < [twoComponents count])
    {
		return NSOrderedDescending;
	}
    else if ([oneComponents count] > [twoComponents count])
    {
		return NSOrderedAscending;
	}
    else if ([oneComponents count] == 1)
    {
		// Neither has an alpha part, and we know the main parts are the same
		return NSOrderedSame;
	}
	
	// At this point the main parts are the same and both have alpha parts. Compare the alpha parts
	// numerically. If it's not a valid number (including empty string) it's treated as zero.
	NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
	NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
	return [oneAlpha compare:twoAlpha];
}

@end

@implementation NSString (URLEncode)

// Use Core Foundation method to URL-encode strings, since -stringByAddingPercentEscapesUsingEncoding:
// doesn't do a complete job. For details, see:
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!'\"();:@&=+$,/?%#[]% ",
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}
- (NSDictionary *)keyValueFromJsonEncode
{
    if (self == nil) return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        DLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end


@implementation NSString(shike)

+ (NSString *)stringFromUpdateTimeString:(NSString *)timeString
{
    return [self stringFromUpdateTime:[timeString doubleValue]];
}
+ (NSString *)stringFromUpdateTime:(double)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [NSString stringWithFormat:@"%d:%02d",[date getHour],[date getMinute]];
}

@end

@implementation NSString(regex)
- (BOOL)isMatchWithRegexString:(NSString *)regexString {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString] evaluateWithObject:self];
}
@end


@implementation NSString(sizeWithFont)
- (CGSize)sizeAutoFitWithFont:(UIFont *)font
{

        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        CGSize size = [self sizeWithAttributes:tdic];
        size.width = ceilf(size.width);
        size.height = ceilf(size.height);
        return size;
 
}


//计算文本的大小
- (CGSize)sizeOfMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}
@end
