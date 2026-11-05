# Overlays: Toolbars, Legends, Tooltips and Pop-ups

An overlay is an element which is drawn above the content of a window and does not move with it: a toolbar, a legend, a tooltip, a pop-up, a menu. This guide gathers the recipes which a viewer of a diagram needs, on top of [Graphical Patterns](GraphicalPatterns.md), which moves and scales the content. The examples were run on the headless host (see [Testing Interactions and Drawing](TestingInteractions.md)).

## 1. Put them in the root of the space

The content is a *world* which is moved and scaled. An overlay in the world would be moved and scaled with it. Add it to the root of the space instead, after the world, so that it is drawn above:

```smalltalk
space root addChild: world.
space root addChild: legend.
```

The root has a basic layout: it does not place its children, so an overlay is placed by its own `position:`. An overlay of a world which can leave the window is added when the world is attached to a space, and removed when it is detached (see [Understanding Scene Graph Attachment](ElementAddedToSceneGraph.md)).

## 2. Anchor a box to a corner

A legend at the bottom left corner of the window computes its position from the extent of its parent, once its own extent is measured. The handler is stable: `measuredBounds position` already has the target, so nothing is requested the second time (see [Layout and Constraints](LayoutAndConstraints.md)).

```smalltalk
legend addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	| target |
	target := 10 @ (legend parent extent y - legend extent y - 10).
	legend measuredBounds position = target ifFalse: [ legend position: target ] ].
```

When the window is resized, the layout of the root is computed again and the legend follows (`space extent: 300 @ 300` moved it from `10 @ 160` to `10 @ 260` in a window of 200 pixels, then 300). Use the same shape for a toolbar at the top right, with the width of its parent.

Compare with `measuredBounds position`, not with `position` or `bounds`, which are the result of the previous layout and never equal the request: see [Layout and Constraints](LayoutAndConstraints.md).

An overlay which is replaced by a new one of the same kind (a legend which is made again when something changes) should keep its element and receive the new content. A new element is at `0 @ 0` until its first layout, and the overlay jumps to the top of the window for a frame.

## 3. A tooltip after a delay

A tooltip is shown when the mouse stayed on an element for a moment, and hidden when it leaves or when the element is clicked. `BlDelayedTaskAction` runs a block on the pulse loop after a duration:

```smalltalk
task := BlDelayedTaskAction new
	delay: 1 second;
	action: [ self showTooltipOf: button ];
	yourself.
button
	addEventHandlerOn: BlMouseEnterEvent do: [ :event | task element: button; startOrRestart ];
	addEventHandlerOn: BlMouseLeaveEvent do: [ :event | task stop. self hideTooltip ];
	addEventHandlerOn: BlClickEvent do: [ :event | task stop. self hideTooltip ].
```

`task element:` must be sent before `startOrRestart`: the task is enqueued on the space of the element. With a delay of 300 milliseconds, the block had not run after 100 milliseconds and had run after 700, and a task stopped before its delay never runs. A click hides the tooltip because it would stay over what the click changed.

## 4. A pop-up near an element, inside the window

The pop-up needs its own size to be placed, and its size is known after its first layout: place it in a handler of `BlElementLayoutComputedEvent`, in the coordinates of the space (`boundsInSpace` of the element it is for), and move it back inside the window.

```smalltalk
popup addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	| anchor target window |
	anchor := button boundsInSpace asRectangle.
	window := space root extent.
	target := (anchor center x - (popup extent x / 2)) @ (anchor bottom + 6).
	target := ((target x min: window x - popup extent x) max: 0)
		@ ((target y min: window y - popup extent y) max: 0).
	popup measuredBounds position = target ifFalse: [ popup position: target ] ].
space root addChild: popup.
```

For a button of `250 @ 20` to `290 @ 40` in a window of 300 pixels, a pop-up of 80 pixels was placed at `220 @ 46`: centered under the button would have put it at 230, partly outside. The same clamp keeps a menu opened at the mouse inside the window, which is the position of the event (`event position`, see [Graphical Patterns](GraphicalPatterns.md)).

Show a single pop-up: remove the existing one before adding a new one, and remove it when the mouse leaves. Fade it in with an animation so that it does not blink:

```smalltalk
popup opacity: 0.
space root addChild: popup.
popup addAnimation: (BlOpacityAnimation new opacity: 1; duration: 140 milliSeconds; yourself).
```

## 5. An overlay must not take the mouse

A pop-up shown next to the element it is for can end up under the mouse. The mouse then leaves the element, which hides the pop-up, which makes the mouse enter the element again: the pop-up blinks. Tell the pop-up not to handle mouse events, so that the elements under it receive them:

```smalltalk
popup preventMeAndChildrenMouseEvents.
```

A tooltip or a pop-up, which only shows something, should always do it. A menu, which is clicked, must not.

## 6. Keep the free area for the content

The toolbar and the legend take strips of the window. A world fitted in the whole window is partly under them. Keep the strips as numbers (the height of the toolbar, the width of the legend and its margin, which are known once the overlays are measured) and fit the content in what is left, see [Graphical Patterns](GraphicalPatterns.md). The overlays are measured after the layout which placed the content: fit again when they are.

## 7. Test them

Send the events to the element and wait longer than the delay:

```smalltalk
button dispatchEvent: BlMouseEnterEvent new.
space settleForDuration: 1300 milliSeconds.
self assert: popup isNotNil.
self assert: ((0 @ 0 extent: space extent) containsRect: popup boundsInSpace asRectangle).

button dispatchEvent: BlMouseLeaveEvent new.
space settleForDuration: 200 milliSeconds.
self assert: popup isNil
```

`dispatchEvent:` is enough for enter and leave events, which do not bubble. A test that the tooltip is *not* shown before the delay waits for less than the delay, so it can be late on a loaded machine: leave a good margin between both.
