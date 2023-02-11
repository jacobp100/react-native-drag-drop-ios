#import <UIKit/UIKit.h>
#import <React/RCTView.h>

typedef NS_OPTIONS(NSInteger, RCTDragDropMode) {
  RCTDragDropModeDrag = 1 << 1,
  RCTDragDropModeDrop = 1 << 2,
};

typedef NS_ENUM(NSInteger, RCTDragDropScope) {
  RCTDragDropScopeSystem,
  RCTDragDropScopeApp,
};

@interface RCTDragDropView : UIView <UIDragInteractionDelegate, UIDropInteractionDelegate>

@property (nonatomic, assign) RCTDragDropScope scope;

@property (nonatomic, assign) RCTDragDropMode mode;

@property (nonatomic, assign) BOOL dragEnabled;
@property (nonatomic, copy) NSString *dragValue;
@property (nonatomic, copy) NSString *dragTypeIdentifier;
@property (nonatomic, copy) RCTDirectEventBlock onDragStart;
@property (nonatomic, copy) RCTDirectEventBlock onDragEnd;

@property (nonatomic, copy) NSArray<NSString *> *dropTypeIdentifiers;
@property (nonatomic, copy) RCTDirectEventBlock onDragEnter;
@property (nonatomic, copy) RCTDirectEventBlock onDragOver;
@property (nonatomic, copy) RCTDirectEventBlock onDragLeave;
@property (nonatomic, copy) RCTDirectEventBlock onDrop;


@end
