# Testing Interactions and Drawing

[Concurrency and Synchronization](2-ConcurrencyAndSynchronization.md) explains how to wait for a space with `settle` and `deferAndSettle:`. This guide adds what a project that builds on Bloc needs to test: running without a window, sending mouse events without a mouse, and checking what is drawn.

## 1. Run on the headless host

A space can be opened on `BlHeadlessHost`: it runs the pulse loop, the layout and the events, without a window. Tests are faster and run on a machine without a display, such as a continuous integration runner.

```smalltalk
space := BlSpace new.
space host: BlHeadlessHost default.
space extent: 300 @ 300.
space root addChild: element.
space show; settle.

"... assertions ..."

space close; settle.
```

`BlSpace >> #host:` must be sent before the space is opened. `BlSpaceTestCase` does exactly this in its `setUp` and closes the space in its `tearDown`: it is the simplest base class.

```smalltalk
BlSpaceTestCase subclass: #MyElementTest.

MyElementTest >> testExtent
	space root addChild: (element := BlElement new extent: 100 @ 50).
	space settle.
	self assert: element extent equals: 100 @ 50
```

The headless host lays out and measures elements, texts included: a `BlTextElement` has its extent after `settle`, as with a window. Anything that needs a real window, such as the screen position of the window or a rendering through the window system, needs another host.

> [!NOTE]
> `BlParameterizedHostTest` runs the same tests on several hosts, and provides `newTestingSpace`. `BlSpaceTestCase` provides the already opened `space`.

When your project loads Bloc with its baseline and no group (`spec baseline: 'Bloc' with: [ spec repository: ... ]`), the package `Bloc-Tests` which holds these classes is loaded with it.

## 2. Send events without a mouse

A test builds the event, then sends it to an element. Two messages exist and they do not do the same:

- `element dispatchEvent: event` gives the event to the handlers of this element only.
- `element fireEvent: event` sends the event the way the mouse does: from the element up to the root of the space, each element on the way being able to handle it.

```smalltalk
node fireEvent: (BlMouseDownEvent new
	position: 5 @ 5;
	screenPosition: 5 @ 5;
	button: BlMouseButton primary;
	yourself)
```

When the event goes up, `event target` is the element it was sent to, and `event currentTarget` the element whose handler runs: for a handler of the root, `target` is `node` and `currentTarget` is the root. A handler which tests `event target == event currentTarget` to find a press on the background is only exercised with `fireEvent:` on a child.

Fill both `position` and `screenPosition` in a mouse event: a handler may read either. They are not the same thing: `position` is the position in the space, the coordinates of the window, and `screenPosition` is the position on the desktop. The hosts fill both (`screenPosition` from the global position of the mouse), so a handler which reads the desktop position works as long as the window is at the corner of the screen. Give them different values in a test, such as `position: 5 @ 5; screenPosition: 905 @ 505`, so that a handler which reads the wrong one fails. The other events:

```smalltalk
BlMouseMoveEvent new position: p; screenPosition: p; yourself.
BlMouseUpEvent new position: p; screenPosition: p; button: BlMouseButton primary; yourself.
BlMouseWheelEvent new position: p; screenPosition: p; vector: (BlVector x: 0 y: 1); yourself.
```

A wheel event with a vector of positive `y` answers `true` to `isScrollUp`.

> [!WARNING]
> A test that sends an event with `dispatchEvent:` to a child, to check that a handler of the root ignores it, passes whatever the handler does: the root never receives the event. Check that such a test can fail, for example by removing the check of the handler for a moment. With `fireEvent:` the test fails as it should.

## 3. After the event

The handlers of the events you send run in your process, but the layout they request runs in the pulse process. Wait before asserting on bounds:

```smalltalk
space root fireEvent: wheelEvent.
space settle.
self assert: world position equals: expected.
```

## 4. Check what is drawn

Layout bounds tell where an element is, not that it is drawn: a child outside of its parent is clipped, and an element can be invisible while having a correct extent. To check the drawing, render the space to a `Form` and look at the pixels:

```smalltalk
form := space root asForm.
filled := 0.
1 to: form width do: [ :x |
	1 to: form height do: [ :y |
		(form colorAt: x @ y) = Color white ifFalse: [ filled := filled + 1 ] ] ].
```

Count the pixels of a rectangle (the screen box of an element, for instance), or compare before and after a change: zooming by 1.21 made the filled area of three nodes grow from 5499 to 8149 pixels, about 1.5 times, close to the square of the zoom (1.46). A count of zero in the box of an element means it is not drawn.

> [!NOTE]
> The rendering of a space to a `Form` also works on the headless host: a `BlElement` of `40 @ 40` with a black border of 10 pixels at `20 @ 20`, rendered with `space root asForm` of a headless space, had a black pixel exactly where the border is, and `Form(200x200x32)` as size.

The borders show why the layout bounds are not enough. The border of an element is drawn inside its bounds by default (`beOutskirtsInside`), centered on its edge (`beOutskirtsCentered`) or outside (`beOutskirtsOutside`), and the bounds are `20 @ 20` to `60 @ 60` in the three cases. Counting the black pixels of the example above gave 1200, 1600 and 2000 pixels for the three: only the rendering tells them apart.

## 5. Take a screenshot

To look at what a test or a script drew, export the root of the space to a PNG. It works on the headless host:

```smalltalk
BAExporter png
	target: FileLocator temp / 'window.png';
	element: space root;
	export.
```

Export the root of the space, which is what the window shows. Exporting a smaller element gives an image of that element and what it draws outside of its bounds (70 by 70 pixels for an element of 50 by 50 with a child which overflows by 20), and an element which is moved or scaled by a transformation (the world of [Graphical Patterns](GraphicalPatterns.md)) does not give what is shown in the window: in a project, the PNG of such a world only had a part of the content. Wait for the space to settle before, and for the animations to end (`settleForDuration:`).

The files can illustrate a README: render a scene from a script with a fixed window size, and read the PNG to check it before committing it.

## 6. Close what you open

A test which opens a space must close it, whatever its outcome, or the window stays open and can interfere with the following tests. Close it in `tearDown`, as `BlSpaceTestCase` does. `Bloc closeSpaces` closes all the spaces of all the hosts; see [Troubleshooting](Troubleshooting.md).
