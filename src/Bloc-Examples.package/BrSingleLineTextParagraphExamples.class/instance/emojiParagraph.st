instance creation
emojiParagraph
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self emoji asRopedText.
	
	^ aParagraph