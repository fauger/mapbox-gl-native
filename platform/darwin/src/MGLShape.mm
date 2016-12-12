#import "MGLShape.h"

#import "NSString+MGLAdditions.h"
#import "MGLTypes.h"

@implementation MGLShape

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        _title = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _subtitle = [coder decodeObjectOfClass:[NSString class] forKey:@"subtitle"];
#if !TARGET_OS_IPHONE
        _toolTip = [coder decodeObjectOfClass:[NSString class] forKey:@"toolTip"];
#endif
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_subtitle forKey:@"subtitle"];
#if !TARGET_OS_IPHONE
    [coder encodeObject:_toolTip forKey:@"toolTip"];
#endif
}

- (BOOL)isEqual:(id)other
{
    if (other == self) { return YES; }
    id <MGLAnnotation> annotation = other;
    
#if TARGET_OS_IPHONE
    return ((!_title && ![annotation title]) || [_title isEqualToString:[annotation title]])
            && ((!_subtitle && ![annotation subtitle]) || [_subtitle isEqualToString:[annotation subtitle]]);
#else
    return ((!_title && ![annotation title]) || [_title isEqualToString:[annotation title]])
            && ((!_subtitle && ![annotation subtitle]) || [_subtitle isEqualToString:[annotation subtitle]])
            && ((!_toolTip && ![annotation toolTip]) || [_toolTip isEqualToString:[annotation toolTip]]);
#endif
}

- (NSUInteger)hash
{
    NSUInteger hash;
    hash += _title.hash;
    hash += _subtitle.hash;
#if !TARGET_OS_IPHONE
    hash += _toolTip.hash;
#endif
    return hash;
}

- (CLLocationCoordinate2D)coordinate
{
    [[NSException exceptionWithName:@"MGLAbstractClassException"
                             reason:@"MGLShape is an abstract class"
                           userInfo:nil] raise];

    return CLLocationCoordinate2DMake(MAXFLOAT, MAXFLOAT);
}

@end
