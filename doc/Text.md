# Working with Text

This guide explains how to display text with `BlTextElement`, what it does not do today, and recipes to build the missing behaviors from simple elements.

> [!TIP]
> `BlTextElement` is the low-level building block that displays a text. For a more powerful widget, such as an input field, a text area or any text with advanced editing features, use [Album](https://github.com/pharo-graphics/Album), the text editor library for Bloc in the `pharo-graphics` organization. The recipes below are meant for the simple cases, such as a label, where a full text widget is more than needed.

> [!NOTE]
> The limitations described in "What a text element does not do" are those observed on the `dev` branch when this page was written. If Bloc gains line breaking or wrapping, this page should be updated.

## 1. Displaying a text

A `BlTextElement` displays a `BlText`. The simplest way to get one is `asRopedText`:

```smalltalk
label := BlTextElement new
	text: 'Hello Bloc' asRopedText;
	yourself.
space root addChild: label.
```

A text element is created with its constraints set to *fit content* on both axes: its extent is the extent of its text. As for any element, the extent is computed by the layout phase of the pulse loop, so it is `0 @ 0` until the space has laid it out (see [Concurrency and Synchronization](2-ConcurrencyAndSynchronization.md) and [Layout and Constraints](LayoutAndConstraints.md)).

## 2. What a text element does not do

### It does not wrap

Giving a text element an exact width does not wrap its text: it stays on one line, as high as one line.

```smalltalk
label := BlTextElement new
	text: 'This is a sentence which is too long for its place' asRopedText;
	constraintsDo: [ :constraints | constraints horizontal exact: 100 ];
	yourself.
space root addChild: label.
space settle.
label extent. ">>> (100.0@13.0): one line"
```

### It does not break lines

A line feed (`Character lf`) or a carriage return (`Character cr`) in the text does not start a new line. It is drawn as a character that cannot be rendered, and the text stays on one line.

```smalltalk
BlTextElement new text: ('first' , (String with: Character lf) , 'second') asRopedText
```

> [!WARNING]
> `BlText >> #printOn:` prints line feeds as `<LF>` and carriage returns as `<CR>`. Seeing `<LF>` in an inspector does not mean the text is drawn on two lines.

## 3. Recipes

The recipes below build multi-line texts from one text element per line, stacked in a vertical linear layout. Wrapping and cutting need the real width of the text, which is only known after a layout: the recipes measure in a handler of `BlElementLayoutComputedEvent` and correct one thing per layout, until the text fits.

> [!IMPORTANT]
> Changing the text of an element requests a new layout, which sends the event again. A handler must stop modifying the text once the situation is stable, otherwise it loops.

### One element per line

```smalltalk
lineBuilder := [ :string |
	BlTextElement new
		text: string asRopedText;
		constraintsDo: [ :constraints | constraints linear horizontal alignCenter ];
		yourself ].

column := BlElement new.
column layout: BlLinearLayout vertical.
column constraintsDo: [ :constraints |
	constraints horizontal fitContent.
	constraints vertical fitContent ].

('first line' , (String with: Character lf) , 'a longer second line') lines do: [ :line |
	column addChild: (lineBuilder value: line) ].
```

The column is as wide as its widest line, and `alignCenter` centers the other lines in it. Use `alignLeft` or `alignRight` for other alignments.

### Wrapping at a maximum width

When a line is wider than the maximum width and has several words, move its last word to the next line. Only one word moves per layout: the next layout measures the new lines again.

```smalltalk
maximumWidth := 100.
wrapped := BlElement new.
wrapped layout: BlLinearLayout vertical.
wrapped constraintsDo: [ :constraints |
	constraints horizontal fitContent.
	constraints vertical fitContent ].
wrapped addChild: (lineBuilder value: 'This is a node with an automatic wrap').

wrapped addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	| overflowing index words |
	overflowing := wrapped children
		detect: [ :line | line extent x > maximumWidth and: [ line text asString substrings size > 1 ] ]
		ifNone: [ nil ].
	overflowing ifNotNil: [
		index := wrapped children indexOf: overflowing.
		words := overflowing text asString substrings.
		overflowing text: (' ' join: words allButLast) asRopedText.
		wrapped children size > index
			ifTrue: [
				| next |
				next := wrapped children at: index + 1.
				next text: (words last , ' ' , next text asString) asRopedText ]
			ifFalse: [ wrapped addChild: (lineBuilder value: words last) at: index + 1 ] ] ].
```

Once settled, the example above shows three lines: `This is a node`, `with an`, `automatic wrap`. A word wider than the maximum width stays alone on its line.

### Cutting with an ellipsis

Remove one character per layout until the text fits, and mark the cut with three dots:

```smalltalk
label := BlTextElement new
	text: 'This is a text which is too long for its place' asRopedText;
	yourself.

label addEventHandlerOn: BlElementLayoutComputedEvent do: [ :event |
	| shown |
	label extent x > 100 ifTrue: [
		shown := label text asString.
		(shown endsWith: '...') ifTrue: [ shown := shown allButLast: 3 ].
		shown isEmpty ifFalse: [ label text: (shown allButLast , '...') asRopedText ] ] ].
```

## 4. Testing a text

Because the width is measured by the layout, a test must wait for the space to settle before checking the lines (`space settle`), and checks the lines of the column rather than a single element:

```smalltalk
space settle.
self assert: wrapped children size equals: 3.
self assert: (wrapped children allSatisfy: [ :line | line extent x <= maximumWidth ])
```

Measuring text works in a space of the headless host, so such tests do not need a window. See [Testing Interactions and Drawing](TestingInteractions.md).

## 5. When a label is not enough: Album

The recipes of this guide build static texts: labels, captions, short messages. They do not select, edit or scroll a text, and each line is an independent element.

[Album](https://github.com/pharo-graphics/Album) is a text editor library based on Bloc. It provides widgets with advanced text edition features, such as an input field or a text area. Prefer it as soon as the user has to type, select or move in a text, or when the text is large. Album was originally forked from the editor of the Brick project.

Check its documentation and its branches before choosing a version: it is a separate project with its own releases.
