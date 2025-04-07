# About Mouse Events

### Mouse over/out and enter/leave events
Let us take a look at what happens when mouse moves between elements and what is the difference between two families of mouse events: enter/leave and over/out.

Quick comparison: hover elements that you obtain when executing 
`BlMouseOverOutAndEnterLeaveEventTest>>#quickComparison`

#### `BlMouseEnterEvent` and `BlMouseLeaveEvent`

If you are looking for the simplest way to detect when a user hovers an element with the mouse use a combination of `BlMouseEnterEvent` and `BlMouseLeaveEvent`.
They trigger when the mouse pointer enters/leaves the element.

`BlMouseEnterEvent` and `BlMouseLeaveEvent` are sent directly (dispatched) to the element, ignoring any mouse transitions inside the element, therefore both mouse enter and leave events do not bubble. In the example below, notice how parent container does not receive mouse leave event when mouse transitions between children:
`BlMouseOverOutAndEnterLeaveEventTest>>#mouseEnterAndLeaveConsumed`

#### `BlMouseOverEvent` and `BlMouseOutEvent`

Similar to the mouse enter but a bit more advanced, `BlMouseOverEvent` occurs when a mouse pointer comes over an element, and `BlMouseOutEvent` – when it leaves:
Check `BlMouseOverOutAndEnterLeaveEventTest>>#basicMouseOverAndOut`

An important feature of mouseout – it triggers, when the pointer moves from an element to its descendant, e.g. from `parent` to `child`. It also means that mouse over/out events bubble.

In the example below, notice how parent container receives mouse out event when mouse transitions from it to deeper child elements:
`BlMouseOverOutAndEnterLeaveEventTest>>#mouseOverAndOutConsumed`


