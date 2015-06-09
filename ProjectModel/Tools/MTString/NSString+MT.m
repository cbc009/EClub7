//
//  NSString+MT.m
//  Club
//
//  Created by dongway on 14-8-20.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "NSString+MT.h"

@implementation NSString (MT)

//时间戳转时间yyyy-MM-dd HH:mm:ss格式
+(NSString *)timeType1FromStamp:(NSString *)stamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString timeFromStamp:stamp withFormatter:formatter];
}

//时间戳转时间HH:mm格式
-(NSString *)timeType2FromStamp:(NSString *)stamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [NSString timeFromStamp:stamp withFormatter:formatter];
}

//时间戳转时间yyyy-MM-dd格式
-(NSString *)timeType3FromStamp:(NSString *)stamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [NSString timeFromStamp:stamp withFormatter:formatter];
}
+(float)heightWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height+3;
}

+(float)widthWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.width;
}

+(NSString *)timeType4FromStamp:(NSString *)stamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [NSString timeFromStamp:stamp withFormatter:formatter];
}

+(NSString *)timeFromStamp:(NSString *)stamp withFormatter:(NSDateFormatter *)formatter{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[stamp doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

-(NSComparisonResult)compareCurrentTimeWith:(NSString *)stamp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[stamp doubleValue]];
    NSDate *currentDate = [NSDate date];
    return [confromTimesp compare:currentDate];
}

//dateString add or reduce second
+(NSString *)dateStringByAddTimeInterval:(NSTimeInterval)timeInterval fromDateString:(NSString *)dateString withDateFormatter:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    date = [date dateByAddingTimeInterval:timeInterval];
    return [dateFormatter stringFromDate:date];
}

//NSDate to NSString
+(NSString *)dateStringFromDate0:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+(NSString *)dateStringFromDate1:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，17,147,18开头11个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end
