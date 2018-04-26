debugging triangle and text
debuggingAlignedIcon
	<gtExample>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	aContainerElement children first debug: true.
	^ aContainerElement