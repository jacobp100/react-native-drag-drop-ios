import {
  NativeSyntheticEvent,
  requireNativeComponent,
  ViewProps,
} from 'react-native';

export type DragDropMode = 'drag' | 'drop' | 'drag-drop';
export type DragDropScope = 'system' | 'app';

export type DropEvent = {
  items: Array<{ value: string | null; type: string }>;
};

export type DragEndEvent = {
  didDrop: boolean;
};

export type DragOverEvent = {
  offsetX: number;
  offsetY: number;
};

export type DropDropViewProps = ViewProps & {
  mode: DragDropMode;
  scope?: DragDropScope;
  dragEnabled?: boolean;
  dragValue?: string;
  dragType?: string;
  onDragStart?: (e: NativeSyntheticEvent<{}>) => void;
  onDragEnd?: (e: NativeSyntheticEvent<DragEndEvent>) => void;
  dropTypes?: string[];
  onDragEnter?: (e: NativeSyntheticEvent<{}>) => void;
  onDragOver?: (e: NativeSyntheticEvent<DragOverEvent>) => void;
  onDragLeave?: (e: NativeSyntheticEvent<{}>) => void;
  onDrop?: (e: NativeSyntheticEvent<DropEvent>) => void;
};

export default requireNativeComponent<DropDropViewProps>('RCTDragDropView');
