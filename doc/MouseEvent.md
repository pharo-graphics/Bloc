# About Mouse Events

## Mouse over/out and enter/leave events

Let us take a look at what happens when the mouse moves between elements and the difference between two families of mouse events: enter/leave and over/out.

Quick comparison: hover elements that you obtain when executing:
`BlMouseOverOutAndEnterLeaveEventTest >> #quickComparison`

### `BlMouseEnterEvent` and `BlMouseLeaveEvent`

If you are looking for the simplest way to detect when a user hovers over an element with the mouse, use a combination of `BlMouseEnterEvent` and `BlMouseLeaveEvent`. They trigger when the mouse pointer enters or leaves the element.

`BlMouseEnterEvent` and `BlMouseLeaveEvent` are sent directly (dispatched) to the element, ignoring any mouse transitions inside the element; therefore, mouse enter and leave events **do not bubble**. In the example below, notice how the parent container does not receive a mouse leave event when the mouse transitions between its children:
`BlMouseOverOutAndEnterLeaveEventTest >> #mouseEnterAndLeaveConsumed`

### `BlMouseOverEvent` and `BlMouseOutEvent`

Similar to mouse enter/leave but with event bubbling, `BlMouseOverEvent` occurs when a mouse pointer comes over an element, and `BlMouseOutEvent` when it leaves:
`BlMouseOverOutAndEnterLeaveEventTest >> #basicMouseOverAndOut`

An important feature of mouse-out: it triggers when the pointer moves from an element to any of its descendant elements (e.g. from a parent to a child). This means mouse over and mouse out events **bubble up the hierarchy**.

In the example below, notice how the parent container receives a mouse out event when the mouse transitions from it to deeper child elements:
`BlMouseOverOutAndEnterLeaveEventTest >> #mouseOverAndOutConsumed`
