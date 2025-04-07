# Getting Started

We count with [a great tutorial](https://github.com/SquareBracketAssociates/Booklet-ASimpleMemoryGame) to get your first journey in Bloc by creating a simple memory game.

Additionally, we provide the following sequence of scripts, as a first glance on Bloc basic concepts, terminology and API:

1. Open a new window (a Bloc _space_, `BlSpace`):
```smalltalk
aSpace := BlSpace new.
aSpace show.

"Edit the space's properties, like title and size"
aSpace title: 'Bloc basics'.
aSpace extent: 800 @ 600.
```

2. Add a first _element_ (`BlElement`) to the space's _root_:
```smalltalk
"Create a red rectangle"
rectangle := BlElement new 
	background: Color red; 
	size: 150 @ 150;
	yourself.
	
"Add it to the space"
aSpace root addChild: rectangle.

"Update its properties"
rectangle 
	background: Color lightBlue;
	position: 100 @ 100;
	border: (BlBorder paint: Color blue width: 10).
```

3. Nest an element with circle _geometry_ (in `BlElementGeometry` hierarchy):
```smalltalk
circle := BlElement new
	background: Color blue;
	geometry: BlCircleGeometry new;
	size: 80 @ 80;
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
rectangle addAnimation: (BlOpacityAnimation new opacity: 0.5).

"Animate transformations"
fallAnimation := (BlTransformAnimation translate: 0 @ 200) absolute.
rectangle addAnimation: fallAnimation.
climbAnimation := (BlTransformAnimation translate: 0 @ 0) absolute.
rectangle addAnimation: climbAnimation.

"Create a sequence of animations"
animationSequence := BlSequentialAnimation withAll: { fallAnimation. climbAnimation }.
animationSequence beInfinite.
rectangle addAnimation: animationSequence
```

7. Handle some _events_:
```smalltalk
"Change color on click"
rectangle addEventHandlerOn: BlClickEvent do: [ :event | event target background: Color lightGray ].

"Animate on hover"
rectangle 
	addEventHandlerOn: BlMouseEnterEvent
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 0.2) ];
	addEventHandlerOn: BlMouseLeaveEvent 
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 1.0) ] 
```

## How Bloc works?

A graphic element (**BlElement**) has properties such as its color, a transformation matrix, a border value, layout rules and so on. If the graphic element is a text, it can have a font-name, font-size, etc. A graphic element can be animated, i.e. its properties can be modified with time based events. A graphic element can have *event handlers* that enable the element to react according to events (e.g. adding a new element inside the graphic element, clicking on it with the mouse, etc.). A graphic element can contain other graphic elements. To display a graphic element on the screen, it must be added to a *space* (**BlSpace**).

A space contains a *frame* which manages the various stages of drawing and event/animation management in Bloc. A frame is made up of different phases. When the "space" receives a *pulse*, the frame calls all the **#runOn:** methods of each phase on the space in turn. The phases are :

1. **Idle:** Do nothing. This is a waiting phase when the space has nothing to do.
2. **Host Validation:** Creates a new window when Pharo is launched. This mechanism is not currently used. I suppose it's complicated to implement with external libraries such as Cairo, which need to create a new handler each time the graphical environment is started.
3. **Task:** Triggers time-based events. The animations for example.
4. **Event:** Updates the focus of elements in the space, then retrieves events from the window (mouse, keyboard, zoom, etc.) and sends them to the various elements in the space.
5. **Drawing Validation:** Checks whether the window needs to redraw elements. For example, if the window has changed size.
6. **Layout:** Computes the layout of the various elements.
7. **Drawing:** Orders the renderer to draw the various elements.

The frame cycle is executed by a host loop `Process`. This is source of frequent questions in Bloc. For example, when user evaluates a script in Workspace that instances an element, establishes its the size (extent), and a few lines below, queries the elemet's width and it is a wrong value (0 tipically). This happens because sending `size:` doesn't take immediate effect; what happens is a layout constraint is set, and a layout pass is requested, and this will be calculated when the frame layout phase is ran in the host loop `Process`. A correct way to access for the calculated width is via #whenLayoutedDoOnce:.
