children - state
stopIgnoringChild: anElement
	"Element can be scrapped and recycled again.
	Note that I remove all information in the element holder"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	anElementHolder stopIgnoring.
	anElementHolder reset.
	anElementHolder flags addInvalid