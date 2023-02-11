#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

#import "RCTDragDropView.h"

@implementation RCTDragDropView {
  UIDragInteraction *_dragInteraction;
  UIDropInteraction *_dropInteraction;
}

- (instancetype)init
{
  if ((self = [super init])) {
    _dragEnabled = YES;
  }
  return self;
}

- (void)setMode:(RCTDragDropMode)mode
{
  _mode = mode;

  BOOL hasDragInteraction = mode & RCTDragDropModeDrag;

  if (!hasDragInteraction && _dragInteraction != nil) {
    [self removeInteraction:_dragInteraction];
    _dragInteraction = nil;
  } else if (hasDragInteraction && _dragInteraction == nil) {
    _dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    _dragInteraction.enabled = _dragEnabled;
    [self addInteraction:_dragInteraction];
  }

  BOOL hasDropInteraction = mode & RCTDragDropModeDrop;

  if (!hasDropInteraction && _dropInteraction != nil) {
    [self removeInteraction:_dropInteraction];
  } else if (hasDropInteraction && _dropInteraction == nil) {
    _dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [self addInteraction:_dropInteraction];
  }
}

- (void)setDragEnabled:(BOOL)dragEnabled
{
  _dragEnabled = dragEnabled;

  if (_dragInteraction != nil) {
    _dragInteraction.enabled = _dragEnabled;
  }
}

// MARK: Drag interaction

- (nonnull NSArray<UIDragItem *> *)dragInteraction:(nonnull UIDragInteraction *)interaction
                          itemsForBeginningSession:(nonnull id<UIDragSession>)session
{
  NSData *item = [_dragValue dataUsingEncoding:NSUTF8StringEncoding];
  NSString *typeIdentifier;
  if (@available(iOS 14.0, *)) {
    typeIdentifier = _dragTypeIdentifier ?: [UTTypePlainText identifier];
  } else {
    typeIdentifier = _dragTypeIdentifier;
  }
  NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithItem:item
                                                       typeIdentifier:typeIdentifier];
  UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
  return @[dragItem];
}

- (BOOL)dragInteraction:(UIDragInteraction *)interaction
sessionIsRestrictedToDraggingApplication:(id<UIDragSession>)session
{
  return _scope == RCTDragDropScopeApp;
}

- (void)dragInteraction:(UIDragInteraction *)interaction
       sessionWillBegin:(id<UIDragSession>)session
{
  if (self.onDragStart) {
    self.onDragStart(@{});
  }
}

- (void)dragInteraction:(UIDragInteraction *)interaction session:(id<UIDragSession>)session didEndWithOperation:(UIDropOperation)operation
{
  if (self.onDragEnd) {
    self.onDragEnd(@{
      @"didDrop": @(operation != UIDropOperationCancel)
    });
  }
}

// MARK: Drop interaction

- (BOOL)dropInteraction:(UIDropInteraction *)interaction
       canHandleSession:(id<UIDropSession>)session
{
  if (_scope == RCTDragDropScopeApp && session.localDragSession == nil) {
    return NO;
  }

  if (_dropTypeIdentifiers != nil && ![session hasItemsConformingToTypeIdentifiers:_dropTypeIdentifiers]) {
    return NO;
  }

  return YES;
}

- (void)dropInteraction:(UIDropInteraction *)interaction
        sessionDidEnter:(id<UIDropSession>)session
{
  if (self.onDragEnter) {
    self.onDragEnter(@{});
  }
}

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction
                   sessionDidUpdate:(id<UIDropSession>)session
{
  if (self.onDragOver) {
    CGPoint offset = [session locationInView:self];
    self.onDragOver(@{
      @"offsetX": @(offset.x),
      @"offsetY": @(offset.y),
    });
  }

  return [[UIDropProposal alloc] initWithDropOperation:UIDropOperationMove];
}

- (void)dropInteraction:(UIDropInteraction *)interaction
         sessionDidExit:(id<UIDropSession>)session
{
  if (self.onDragLeave) {
    self.onDragLeave(@{});
  }
}

- (void)dropInteraction:(UIDropInteraction *)interaction
            performDrop:(id<UIDropSession>)session
{
  if (!self.onDrop) {
    return;
  }

  NSMutableArray *pending = [NSMutableArray new];

  for (UIDragItem *item in session.items) {
    NSItemProvider *itemProvider = item.itemProvider;
    NSString *typeIdenfifier = [itemProvider.registeredTypeIdentifiers firstObject];
    if (typeIdenfifier == nil || (_dropTypeIdentifiers != nil && ![_dropTypeIdentifiers containsObject:typeIdenfifier])) {
      continue;
    }

    [pending addObject:itemProvider];
  }

  NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:pending.count];
  __block NSUInteger remaining = pending.count;

  void (^setItem)(int index, NSString *typeIdenfifier, NSData * _Nullable data) = ^(int index, NSString *typeIdenfifier, NSData * _Nullable data) {
    id value;
    if (data != nil) {
      value = [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding];
    } else {
      value = [NSNull null];
    }

    items[index] = @{ @"value": value, @"type": typeIdenfifier };

    remaining -= 1;

    self.onDrop(@{
      @"items": items
    });
  };

  for (int i = 0; i < pending.count; i += 1) {
    NSItemProvider *itemProvider = pending[i];
    NSString *typeIdenfifier = itemProvider.registeredTypeIdentifiers[0];
    [itemProvider loadDataRepresentationForTypeIdentifier:typeIdenfifier
                                        completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
      setItem(i, typeIdenfifier, error == nil ? data : nil);
    }];
  }
}

@end
