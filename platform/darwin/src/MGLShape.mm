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
#if TARGET_OS_MACOS
        _toolTip = [coder decodeObjectOfClass:[NSString class] forKey:@"toolTip"];
#endif
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_subtitle forKey:@"subtitle"];
#if TARGET_OS_MACOS
    [coder encodeObject:_toolTip forKey:@"toolTip"];
#endif
}

- (BOOL)isEqual:(id)other
{
    if (other == self) { return YES; }
    id <MGLAnnotation> annotation = other;
    
#if TARGET_OS_MACOS
    return (MGLIsEqualToString(_title, [annotation title])
            && MGLIsEqualToString(_subtitle, [annotation subtitle])
            && MGLIsEqualToString(_toolTip, [annotation toolTip]));
#else
    return (MGLIsEqualToString(_title, [annotation title])
            && MGLIsEqualToString(_subtitle, [annotation subtitle]));
#endif
}

- (NSUInteger)hash
{
    NSUInteger hash;
    hash += _title.hash;
    hash += _subtitle.hash;
#if TARGET_OS_MACOS
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
