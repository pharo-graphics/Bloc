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

The handler runs on the pulse process. An error in it opens a debugger that blocks the host (see [Troubleshooting](Troubleshooting.md)).

## 6. Clipping

By default, an element clips its children to its bounds (`clipChildren` is true). A child placed partly or completely outside of its parent is cut or invisible. This is usually the explanation of an element that exists but is not drawn.

```smalltalk
parent clipChildren: false
```

The window also clips: nothing is drawn outside of the root of the space. See [Graphical Patterns](GraphicalPatterns.md) for content bigger than the window.
