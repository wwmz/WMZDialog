//
//  WMZTagConfig.h
//  WMZTags
//
//  Created by wmz on 2019/9/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#ifndef WMZTagConfig_h
#define WMZTagConfig_h

#import <UIKit/UIKit.h>
#import "Masonry.h"


#define MColor  [WMZTagsTool stringTOColor:@"#5297E1"]
#define MInnerColor  [WMZTagsTool stringTOColor:@"#CEE1F7"]
#define MBoderColor  [WMZTagsTool stringTOColor:@"#5297E1"]

#define MSelectColor  [WMZTagsTool stringTOColor:@"#ED4985"]
#define MSelectInnerColor  [WMZTagsTool stringTOColor:@"#F4C4C4"]
#define MSelectBoderColor  [WMZTagsTool stringTOColor:@"#ED4985"]

#define MInsertPlaceholder  @"+New tag"

#define TagWitdh  [UIScreen mainScreen].bounds.size.width
#define TagHeight [UIScreen mainScreen].bounds.size.height

#define WMZPropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define WMZPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}

#endif /* WMZTagConfig_h */
