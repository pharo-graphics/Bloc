# Getting Started

This guide introduces the core concepts, terminology, and API of Bloc through a sequence of interactive scripts you can evaluate in the Playground:

1. Open a new window (a Bloc _space_, `BlSpace`):
```smalltalk
aSpace := BlSpace new.
aSpace open.

"Edit the space's properties, like title and extent"
aSpace title: 'Bloc basics'.
aSpace extent: 800 @ 600.
```

2. Add a first _element_ (`BlElement`) to the space's _root_:
```smalltalk
"Create a red rectangle"
rectangle := BlElement new
	background: Color red;
	extent: 150 @ 150;
	yourself.

"Add it to the space"
aSpace root addChild: rectangle.

"Update its properties"
rectangle
	background: Color lightBlue;
	position: 100 @ 100;
	border: (BlBorder paint: Color blue width: 10).
```

   A border is drawn **inside** the bounds of the element by default. Choose where it is drawn with the _outskirts_: `beOutskirtsInside`, `beOutskirtsCentered` (half inside and half outside of the edge) or `beOutskirtsOutside`. The bounds of the element are the same in the three cases, only the pixels change: for a black border of 10 pixels around an element of `40 @ 40`, the rendering has 1200, 1600 and 2000 black pixels.
```smalltalk
rectangle beOutskirtsCentered.
```

3. Nest an element with circle _geometry_ (in `BlElementGeometry` hierarchy):
```smalltalk
circle := BlElement new
	background: Color blue;
	geometry: BlCircleGeometry new;
	extent: 80 @ 80;
	yourself.
rectangle addChild: circle.
```

4. Turn off _clipping_ to show children overflow:
```smalltalk
rectangle clipChildren: false.
```

5. Transform child (to resize it):
```smalltalk
circle transformDo: [ :builder | builder scaleBy: 1.2 ].
```

6. Play some _animations_:
```smalltalk
"Animate opacity"
rectangle addAnimation: (BlOpacityAnimation new opacity: 0.5; yourself).

"Animate transformations"
fallAnimation := (BlTransformAnimation translate: 0 @ 200) absolute.
rectangle addAnimation: fallAnimation.
climbAnimation := (BlTransformAnimation translate: 0 @ 0) absolute.
rectangle addAnimation: climbAnimation.

"Create a sequence of animations"
animationSequence := BlSequentialAnimation withAll: { fallAnimation. climbAnimation }.
animationSequence beInfinite.
rectangle addAnimation: animationSequence.
```

7. Handle some _events_:
```smalltalk
"Change color on click"
rectangle addEventHandlerOn: BlClickEvent do: [ :event | event target background: Color lightGray ].

"Animate on hover"
rectangle
	addEventHandlerOn: BlMouseEnterEvent
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 0.2; yourself) ];
	addEventHandlerOn: BlMouseLeaveEvent
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 1.0; yourself) ].
```

---

## What's Next?

You now have a working grasp of visual elements, geometries, styling, animations, and event handlers.

However, Bloc windows do not run synchronously on the main UI thread: each open space is driven by its own background **host pulse process**. When you modify an element from the Playground, a test, or a worker thread, your code runs concurrently with the display loop.

To understand the frame cycle, why querying bounds immediately can answer `0`, and how to coordinate your code with the pulse loop using the Settle and Defer API, continue to:

👉 **[2. Concurrency and Synchronization in Bloc](2-ConcurrencyAndSynchronization.md)**
