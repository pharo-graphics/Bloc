instance creation
emptyParagraph
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: BlText empty.
	
	^ aParagraph