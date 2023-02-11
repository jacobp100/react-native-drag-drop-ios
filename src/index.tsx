import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-drag-drop-ios' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type DragDropIosProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'DragDropIosView';

export const DragDropIosView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<DragDropIosProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
