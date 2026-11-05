# Graphical Patterns: Zoom, Pan and Fit

This guide gathers basic patterns to manage the way a graphic is shown: scaling it, moving it with the mouse, and making sure it is visible. They are the building blocks of any viewer of a diagram, a map or a graph.

Every example works on a *world*: an element which holds the content and that we move and scale as a whole.

## 1. Transformations

An element can be transformed (scaled, rotated, translated) without changing its layout bounds:

```smalltalk
element transformDo: [ :builder | builder scaleBy: 2 @ 2 ].
```

Two properties are easy to miss.

**The origin is the center of the element by default.** For an element of `100 @ 100` at `100 @ 100`, `scaleBy: 2 @ 2` grows it around its center. Choose another origin in the same block:

```smalltalk
element transformDo: [ :builder |
	builder
		topLeftOrigin;
		scaleBy: 2 @ 2 ].
```

**A transformation is absolute.** Applying `scaleBy: 3 @ 3` after `scaleBy: 2 @ 2` gives a scale of 3, not 6. For an element of `50 @ 50`, the transformed extent is `100 @ 100` after the first, and `150 @ 150` after the second. To scale by a factor, compute the new total scale from the previous one.

**`transformedBounds` are in the coordinates of the element**, without its position. For the element above, with the center as origin, they are `-50 @ -50` to `150 @ 150`, and with `topLeftOrigin` they are `0 @ 0` to `200 @ 200`, whatever the position of the element in its parent.

## 2. The model: an origin and a zoom

A world is placed by two values: where its top left corner is (`origin`, in the coordinates of the window), and its scale (`zoom`). Applying them is always the same:

```smalltalk
world := BlElement new
	clipChildren: false;
	yourself.
space root addChild: world.

origin := 0 @ 0.
zoom := 1.
apply := [
	world position: origin.
	world transformDo: [ :builder |
		builder
			topLeftOrigin;
			scaleBy: zoom @ zoom ] ].
```

A point `p` of the content is drawn at `origin + (zoom * p)` in the window. All the interactions below only change `origin` and `zoom`, then evaluate `apply`.

## 3. Zoom around the mouse

Zooming around the top left corner moves the content away from the mouse. To keep the point under the mouse where it is, change the origin with the zoom. The point under the mouse is `(cursor - origin) / zoom` before the zoom, and it must be the same after:

```smalltalk
space root addEventHandlerOn: BlMouseWheelEvent do: [ :event |
	| newZoom cursor |
	newZoom := ((zoom * (event isScrollUp ifTrue: [ 1.1 ] ifFalse: [ 1 / 1.1 ]))
		min: 10) max: 0.1.
	cursor := event position.
	origin := cursor - ((newZoom / zoom) * (cursor - origin)).
	zoom := newZoom.
	apply value ].
```

Keep a minimum and a maximum zoom: without them a long scroll makes the content vanish or exceed the numbers a graphic can hold.

## 4. Pan with the mouse

Pressing the background and dragging moves the world by the distance the mouse moved:

```smalltalk
dragFrom := nil.
space root
	addEventHandlerOn: BlMouseDownEvent do: [ :event |
		event target == event currentTarget ifTrue: [ dragFrom := event position ] ];
	addEventHandlerOn: BlMouseMoveEvent do: [ :event |
		dragFrom ifNotNil: [
			origin := origin + (event position - dragFrom).
			dragFrom := event position.
			apply value ] ];
	addEventHandlerOn: BlMouseUpEvent do: [ :event | dragFrom := nil ].
```

Zoom and pan share `origin`, so they combine: dragging after a zoom still moves the content by the distance of the mouse.

### Where to install the handlers

The mouse events of the background arrive on the root of the space. Install the handlers there, and not on the world, which only covers its content.

A press on an element of the content also arrives at the root: events go up from the element to the root. The test `event target == event currentTarget` tells them apart: `target` is the element under the mouse, `currentTarget` the element whose handler is running. It is true only for the background, so that pressing a node can be used for something else than panning.

> [!WARNING]
> Use `position`, the position of the mouse in the space, which is the coordinates of the root and so the ones of the window. `screenPosition` is the position on the desktop: it is the same only for a window at the top left corner of the screen, and a zoom or a pan computed with it is wrong as soon as the window is moved. `localPosition` and `parentPosition` are the position in the coordinates of `currentTarget` and of its parent. The distance used by a pan or a drag does not depend on the element which receives the event, because `position` is always in the space.

## 5. Fit the content in the window

The content of a diagram is often computed with coordinates that do not start at zero, or that are negative (a label above the first node). Bloc draws nothing outside the root of the space, and `clipChildren` (default `true`) cuts what is outside of a parent.

The pattern is to compute the top left corner of the content once its layout is done, and to place the world so that this corner is at a margin of the window:

```smalltalk
world addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	| corners topLeft |
	corners := world children collect: [ :child | child position ].
	topLeft := corners isEmpty
		ifTrue: [ 0 @ 0 ]
		ifFalse: [ (corners collect: #x) min @ (corners collect: #y) min ].
	origin := 10 @ 10 - (topLeft * zoom) + panOffset.
	apply value ]
```

where `panOffset` is what the user moved. Keep the user's offset apart from the fit: zoom and pan only change `panOffset`, and the fit recomputes the origin from it, otherwise each layout undoes the user's move. Remember that a handler of `BlElementLayoutComputedEvent` must be stable (see [Layout and Constraints](LayoutAndConstraints.md)): placing the world at the same origin again does not request another layout, because `position:` ignores a position it already has.

### A fit which has to be repeated

A fit computed once is wrong when the content is not final: the labels around nodes, for example, are measured after the layout which placed the nodes, and the window may have strips taken by a toolbar or a legend. Two rules keep a fit right:

- Fit in the *free area* of the window, a rectangle without the strips which overlays take (see [Overlays](Overlays.md)), and not in the whole window. Reserve them as numbers (a height at the top, a width at the left) and subtract them from the extent of the window.
- Fit again each time the rectangle of the content, or the free area, is not the one of the last fit, until the user zooms, pans or drags something. Remember both rectangles when you fit and compare them in the handler of `BlElementLayoutComputedEvent`: the fit then follows a content which grows over a few layouts, and stops following as soon as the user takes control. A button which fits on demand can offer the same fit again, and a switch can let the user turn the repeated fit off.

The rectangle of the content must include everything which is drawn, not only the nodes: the labels, which are outside of their node, and what a node draws outside of its bounds. A zoom limit (see above) applies to the fit too, otherwise a content of one node is enlarged to the size of the window.

## 6. Install on attachment

The root of the space exists only once the world is in a space. Install the handlers when the world is attached, and remove them when it is detached, so that a world removed from a window does not keep reacting to it. See [Understanding Scene Graph Attachment](ElementAddedToSceneGraph.md).

```smalltalk
handler := BlEventHandler on: BlMouseWheelEvent do: [ :event | "zoom" ].
installedOn := nil.

world addEventHandlerOn: BlElementAddedToSceneGraphEvent do: [ :event |
	installedOn := world space root.
	installedOn addEventHandlerIfNotPresent: handler ].
world addEventHandlerOn: BlElementRemovedFromSceneGraphEvent do: [ :event |
	installedOn removeEventHandler: handler ]
```

Use `addEventHandlerIfNotPresent:`: the attachment event can reach the handler of the world more than once, and a handler installed twice would zoom twice. Keep the root in a variable, because when the removal event is sent the world is not attached anymore and `world space` answers `nil`. For several handlers, a small class holding the world and the root, and installing and removing itself, keeps the code readable (`onInstalledIn:` and `onUninstalledIn:` are the hooks of `BlBasicEventHandler`).
