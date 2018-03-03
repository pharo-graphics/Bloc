instance creation
habaParagraph
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self haba asRopedText.
	
	^ aParagraph