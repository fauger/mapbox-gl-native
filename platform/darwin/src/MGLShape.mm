#import "MGLShape.h"

#import "NSString+MGLAdditions.h"
#import "MGLTypes.h"

#import <mbgl/util/geo.hpp>

bool compareByCoordinate(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs)
{
    return lhs.latitude+lhs.longitude < rhs.latitude+rhs.longitude;
}

bool operator!=(const CLLocationCoordinate2D lhs, const CLLocationCoordinate2D rhs) {
    return lhs.latitude != rhs.latitude || lhs.longitude != rhs.longitude;
}

bool operator==(std::vector<CLLocationCoordinate2D>& lhs, std::vector<CLLocationCoordinate2D>& rhs)
{
    if (lhs.size() != rhs.size()) return false;
    
    std::sort(lhs.begin(), lhs.end(), compareByCoordinate);
    std::sort(rhs.begin(), rhs.end(), compareByCoordinate);
    
    auto itLhs = lhs.begin();
    auto itRhs = rhs.begin();
    
    while (itLhs != lhs.end() || itRhs != rhs.end())
    {
        if (*itLhs != *itRhs)
            return false;
        
        if (itLhs != lhs.end()) ++itLhs;
        if (itRhs != rhs.end()) ++itRhs;
    }
    
    return true;
}

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
