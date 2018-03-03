instance creation
emptyParagraph
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: BrText empty.
	
	^ aParagraph