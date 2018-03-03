instance creation
newParagraph
	<gtExample>
	| aParagraph |

	aParagraph := BrSingleLineTextParagraph new.

	self assert: aParagraph containerExtent equals: 0@0.
	self assert: aParagraph hasWidthLimit not.
	self assert: aParagraph hasHeightLimit not.
	self assert: aParagraph wantsAutoRelease.
	
	^ aParagraph