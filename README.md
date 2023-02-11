# react-native-drag-drop-ios

<a href="https://jacobdoescode.com/technicalc"><img alt="Part of the TechniCalc Project" src="https://github.com/jacobp100/technicalc-core/blob/master/banner.png" width="200" height="60"></a>

Native drag and drop behaviour for iOS

https://user-images.githubusercontent.com/7275322/218277637-a451b141-7a58-48c1-a8e5-9fe28abeb32a.mp4

## Installation

```sh
npm install react-native-drag-drop-ios
```

## Usage

```js
import DragDropView from 'react-native-drag-drop-ios';

<DragDropView mode="drag-drop" />;
```

### Common Props

| Prop    | Type                                 | Description                                                                                                        |
| ------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| `mode`  | `"drag"`, `"drop"`, or `"drag-drop"` | Interactions to enable on the view. It's recommended you don't change this value after mounting (see other props). |
| `scope` | `"system"` or `"app"`                | Whether to allow dragging to and dropping from outside the app into other apps.                                    |

### Dragging

| Prop          | Type     | Description                                                                                                                                                               |
| ------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `dragEnabled` | bool     | Disable drag interactions if they were enabled by `mode`.                                                                                                                 |
| `dragValue`   | string   | The value the dragged item has. Use `JSON.stringify` if you need an object as the value.                                                                                  |
| `dragType`    | string   | Used in conjunction with `dropTypes`. The default is a _plain text_ type that the system understands - if you chaange this, you will not be able to drag outside the app. |
| `onDragStart` | function | Called when a drag interaction starts.                                                                                                                                    |
| `onDragEnd`   | function | Called when a drag interaction ends. Contains a `didDrop` event in `e.nativeEvent`.                                                                                       |

### Dropping

| Prop          | Type             | Description                                                                                                                                                                           |
| ------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `dropTypes`   | array of strings | Accepts only drops from items with certain `dragType`s. The default is a _plain text_ type that can come from outside the app. Set to an empty array to temporarily disable dropping. |
| `onDropEnter` | function         | Called when a drag interaction enters this drop target.                                                                                                                               |
| `onDragOver`  | function         | Called when a drag is moving over this drop target. Contains `offsetX` and `offsetY` in `e.nativeEvent`.                                                                              |
| `onDragLeave` | function         | Called when a drag interaction leaves this drop target.                                                                                                                               |
| `onDrop`      | function         | Called when a drop interaction finishes on this drop target. Contains `items` in `e.nativeEvent`, which is an array items matching type `{ type, value }`                             |

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
