bounds
debuggingMisalignedIcon
	<gtExample>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first debug: true.
	^ aContainerElement