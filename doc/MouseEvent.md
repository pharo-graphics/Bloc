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

## Clicks

The mouse processor of the space (`BlMouseProcessor`) turns a press and a release into a click, a double click, a click aborted event or a drag. The rules, from its code:

- A `BlClickEvent` is sent when the button is released on the **same element** where it was pressed, the release event was **not consumed**, and **no drag and drop is in progress**. The mouse can have moved between the press and the release: a mouse press, a few moves and a release on the same element are a click. A handler which moves an element with `BlMouseMoveEvent` ends the move with a click, on the element or on the one it moved to.
- When the release is on another element, a `BlClickAbortedEvent` is sent to the element of the press instead.
- A release on the same element, with the same button, shortly after the previous click (`BlMouseProcessor`'s `DoubleClickDuration`) sends a `BlDoubleClickEvent` **instead of** the second `BlClickEvent`.
- A drag and drop starts when the primary button is down and the mouse went more than 4 pixels from the press: a `BlDragStartEvent` is sent to the element under the mouse, and the drag only starts if a handler consumes it (`event consume`). From then on there is no click at the end.

To tell a click from the end of a move you made yourself, either start a real drag and drop (consume the drag start), or remember in a flag that the element was moved since the press, reset it on `BlMouseDownEvent`, and ignore the click when it is set. A distance threshold avoids a drag for a press with a tiny movement.

## An event is for the element under the mouse and its parents

Mouse events go up from the element under the mouse to the root, so a handler of an element also receives the events of its children: a click on the label of a node, or on a node inside another node, reaches the handler of the outer node too. To react only to the events of the nearest element of a kind, walk up from `event target` and compare:

```smalltalk
"isNode answers whether an element is one of your nodes"
isForNode := [ :event :node :isNode |
	| current |
	current := event target.
	[ current isNotNil and: [ (isNode value: current) not ] ] whileTrue: [ current := current parent ].
	current isNil or: [ current == node ] ].

outerNode addEventHandlerOn: BlClickEvent do: [ :event |
	(isForNode value: event value: outerNode value: [ :element | element class = MyNodeElement ])
		ifTrue: [ "the click is for this node" ] ]
```

A click on an inner node is then for the inner node only, a click on a label is for the node which has it, and a click on the background (where no node is above) is for no node. Unlike `event consume`, this does not stop the other handlers of the parents, which can still want the event.

`dispatchEvent:` and `fireEvent:` in a test do not go through the mouse processor: they send the event you build, so a test of a click sends `BlClickEvent` itself, and the rules above are not exercised. `BlDevScripter` (package `Bloc-Scripter`) plays clicks (`click`), double clicks (`doubleClick`) and secondary clicks (`secondaryClick`) with simulated mouse events and waits for the space to settle: look at it when the behavior of the click matters.
