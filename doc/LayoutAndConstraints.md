# Layout and Constraints

This guide explains how an element gets its size and position: the constraints it carries, the layout of its parent, and how to react to a layout without looping.

## 1. Three actors

- The **constraints** of an element (`element constraints`) say what the element wants: a size policy on each axis, and a position.
- The **layout** of its parent (`parent layout`) reads the constraints of its children and computes their bounds. The default layout is `BlBasicLayout`. Others are `BlFrameLayout`, `BlLinearLayout`, `BlFlowLayout`...
- The **bounds** (`element bounds`, `element extent`, `element position`) are the result. They are computed by the layout phase of the pulse loop (see [Concurrency and Synchronization](2-ConcurrencyAndSynchronization.md)).

Setting a constraint therefore never changes the bounds immediately.

## 2. Size policies

Each element has constraints with one *axis* per direction. An axis has a size policy:

```smalltalk
element constraintsDo: [ :constraints |
	constraints horizontal exact: 200.
	constraints vertical fitContent ].
```

- `exact: aNumber` — the element has this size. `element extent: 200 @ 100` is the shortcut for an exact size on both axes.
- `fitContent` — the element is as large as its content (its children, or its text for a `BlTextElement`).
- `matchParent` — the element takes the size of its parent.

`constraintsDo:` evaluates the block with the constraints and then requests a layout. Prefer it to reading `constraints` and changing it yourself.

## 3. Constraints specific to a layout: the facets

The constraints of an element also give access to the options of each kind of layout. They are separate *facets* of the same object:

```smalltalk
parent layout: BlFrameLayout new.
child constraintsDo: [ :constraints |
	constraints frame horizontal alignCenter.
	constraints frame vertical alignCenter ].

column layout: BlLinearLayout vertical.
line constraintsDo: [ :constraints | constraints linear horizontal alignRight ].
```

Only the facet of the parent's layout is used by that layout. A frame option on a child of a linear layout is ignored.

> [!WARNING]
> Do not replace the constraints of an element with `element constraints: BlFrameLayoutConstraints new`. A layout-specific constraints object does not have the size policies and the position of the common constraints. The element then fails to be laid out: `position:` is not understood, and the layout stops with `BlFrameLayoutConstraintsHorizontal >> #resizer` not understood. A `BlTextElement` also loses its initial `fitContent`.

## 4. The position is a request

`element position: aPoint` does not move the element. It records the position in the constraints and asks the parent for a layout; the element moves during that layout. In the code of Bloc, `position:` does nothing when the measured bounds already have this position.

```smalltalk
element position: 100 @ 50.
element position. ">>> may still answer the previous position"
space settle.
element position. ">>> 100 @ 50"
```

`position` and `bounds` answer the result of the last layout. `measuredBounds` holds the values requested or measured for the next layout: `position:` updates it immediately, and it is what Bloc compares the new position with.

## 5. Reacting to a layout

Some computations need the size of an element after its layout: placing a label around a node, wrapping a text, fitting a content in a window. Handle `BlElementLayoutComputedEvent`, which is sent to an element once its layout is computed:

```smalltalk
element addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	"Read the extents here, and correct what depends on them" ].
```

> [!IMPORTANT]
> Anything that changes the constraints, the position or the content of an element requests a new layout, which sends the event again. A handler must change something only when it differs from what is already there, so that the second layout finds nothing to do. See the recipes in [Working with Text](Text.md), which correct one thing per layout.

`whenLayoutedDo:` installs such a handler for every layout, and `whenLayoutedDoOnce:` for the next one only. The block of the second one can register itself again to follow the following layouts.

```smalltalk
element whenLayoutedDoOnce: [ element extent ">>> the size computed by the layout" ].
```

The handler runs on the pulse process. An error in it opens a debugger that blocks the host (see [Troubleshooting](Troubleshooting.md)).

A space computes at most 100 layouts per frame, and writes `Warning: Layout was performed 50 times per frame!` in the Transcript at the 50th. A handler which changes something at each layout raises no error: the layout is still requested at the end of the frame, and the work starts again in the next one. If a window becomes slow after you added a handler, look at the Transcript.

## 6. Clipping

By default, an element clips its children to its bounds (`clipChildren` is true). A child placed partly or completely outside of its parent is cut or invisible. This is usually the explanation of an element that exists but is not drawn.

```smalltalk
parent clipChildren: false
```

The window also clips: nothing is drawn outside of the root of the space. See [Graphical Patterns](GraphicalPatterns.md) for content bigger than the window.

## 7. Sizes before the first layout

`extent`, `width` and `height` answer the size measured by the last layout. Before the first one they answer `0 @ 0`, even when the extent was requested:

```smalltalk
element := BlElement new extent: 30 @ 20.
element extent. ">>> 0 @ 0"
space root addChild: element.
space settle.
element extent. ">>> 30 @ 20"
```

`measuredBounds extent` answers `0 @ 0` too: it only gets the extent once the layout computed it (the position, in contrast, is recorded at once, see section 4).

When the size is exact (`extent:` or `exact:`), `requestedExtent` answers it at once, before any layout:

```smalltalk
element := BlElement new extent: 30 @ 20.
element requestedExtent. ">>> 30 @ 20"
```

Only an exact size can be known before the layout: for a `fitContent` element, `requestedExtent` answers `0 @ 0`, as its comment warns.

Code which needs a size before the layout, such as another library asking `node width` while it places the nodes, must not read it from `extent`. If the size is exact, ask `requestedExtent`. Otherwise keep the requested size in your own model (a `dimension` instance variable which `extent:` is sent from), and answer it. A library which sends `width` to the element itself needs it redefined: Bloc advises against redefining `width` and `height` (a lint rule checks it), and doing it is only safe when the extent of the element is always its model's dimension, so that Bloc and the other library see the same size.

## 8. Computations which depend on measured children

The text of a label is measured by the layout, and its position is requested by a handler of `BlElementLayoutComputedEvent`, which requests another layout. A computation made from the bounds of such children, for example the route of a line around the nodes and their labels, is therefore wrong when it is made before the layouts are done, and it can be wrong after the first one.

A pattern which works: make the computation when the content changes, remember the bounds it used, and make it again after each following layout until these bounds were the same for a few layouts in a row. `whenLayoutedDoOnce:` (see section 5), registered again from its own block, is enough to build it:

```smalltalk
watch := nil.
watch := [
	element whenLayoutedDoOnce: [
		current := self boundsOfTheNodesAndTheirLabels.
		current = used
			ifTrue: [ stable := stable + 1 ]
			ifFalse: [ used := current. stable := 0. self computeTheRoutes ].
		stable < 4 ifTrue: [ watch value ] ] ].
```

The bounds must be computed from sizes, not read from positions, which are the ones of the previous layout: the place of a label next to its node is its size and its placement rule, not `label position`.

## 9. Moving a child to another parent

`addChild:` raises `BlAlreadyAddedAsChildError` when the element already has a parent, even another one (the error has no message). Remove it first:

```smalltalk
child removeFromParent.
newParent addChild: child.
"or, for all the children of a parent"
oldParent removeChildren.
```

To move all the children, take them first (`children := oldParent children asArray`), then `removeChildren`, then add them one by one. Elements which were children of the old parent have no parent after `removeChildren`.
