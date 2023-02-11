#import <React/RCTConvert.h>

#import "RCTDragDropViewManager.h"
#import "RCTDragDropView.h"

@implementation RCTConvert (RCTDragDrop)

RCT_MULTI_ENUM_CONVERTER(
  RCTDragDropMode,
  (@{
    @"drag" : @(RCTDragDropModeDrag),
    @"drop" : @(RCTDragDropModeDrop),
    @"drag-drop" : @(RCTDragDropModeDrag | RCTDragDropModeDrop),
  }),
  0,
  integerValue);

RCT_MULTI_ENUM_CONVERTER(
  RCTDragDropScope,
  (@{
    @"system" : @(RCTDragDropScopeSystem),
    @"app" : @(RCTDragDropScopeApp),
  }),
  RCTDragDropScopeSystem,
  integerValue);

@end


@implementation RCTDragDropViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [RCTDragDropView new];
}


RCT_EXPORT_VIEW_PROPERTY(mode, RCTDragDropMode)
RCT_EXPORT_VIEW_PROPERTY(scope, RCTDragDropScope)

RCT_EXPORT_VIEW_PROPERTY(dragEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(dragValue, NSString)
RCT_REMAP_VIEW_PROPERTY(dragType, dragTypeIdentifier, NSString)
RCT_EXPORT_VIEW_PROPERTY(onDragStart, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDragEnd, RCTDirectEventBlock)

RCT_REMAP_VIEW_PROPERTY(dropTypes, dropTypeIdentifiers, NSArray)
RCT_EXPORT_VIEW_PROPERTY(onDragEnter, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDragOver, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDragLeave, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDrop, RCTDirectEventBlock)

@end
