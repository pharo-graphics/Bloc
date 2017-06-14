private
createAttributesFor: aSpace
	| theAttributes |
	theAttributes := OSWindowAttributes new.
	theAttributes
		extent: aSpace extent;
		resizable: aSpace resizable;
		borderless: aSpace borderless;
		position: aSpace position;
		visible: false. "There is a race before opening a window and setting the event handler."
	^ theAttributes