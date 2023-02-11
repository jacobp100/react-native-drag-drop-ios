import * as React from 'react';
import { StyleSheet, View, Text, Alert } from 'react-native';
import DragDropView, { DropDropViewProps } from 'react-native-drag-drop-ios';

const Box = ({ title, ...props }: DropDropViewProps & { title: string }) => (
  <DragDropView
    {...props}
    dragValue={title}
    onDrop={(e) => Alert.alert(`Dropped: "${e.nativeEvent.items[0]?.value!}"`)}
    style={[styles.box, props.style]}
  >
    <Text style={styles.text}>{title}</Text>
  </DragDropView>
);

export default function App() {
  return (
    <View style={styles.container}>
      <Box mode="drag" title="Drag me" />
      <Box mode="drop" title="Drop on me" />
      <Box mode="drag-drop" title="Drag me or drop on me" />
      <Box
        mode="drag"
        dragType="red"
        title="Red drag item"
        style={styles.redBox}
      />
      <Box
        mode="drop"
        dropTypes={['red']}
        title="Drop red items on me"
        style={styles.redBox}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: 8,
  },
  box: {
    justifyContent: 'center',
    minWidth: 60,
    minHeight: 60,
    padding: 12,
    backgroundColor: '#333',
    borderRadius: 12,
  },
  redBox: {
    backgroundColor: '#933',
  },
  text: {
    fontWeight: '900',
    fontSize: 20,
    color: 'white',
  },
});
