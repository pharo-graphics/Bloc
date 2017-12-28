bounds conversion
localBoundsToSpace: aBounds
	"In-place transform bounds from local coordinates to space coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>
	| aCurrentElement |

	aCurrentElement := self referenceElement.

	[
		"first apply transformation if we have one"
		aCurrentElement transformation transformBounds: aBounds.

		"then translate according to my position within the parent.
		Note, that an element might have a position even if it does not have a parent"
		aBounds translateBy: aCurrentElement position.
	]
	"we must evaluate a transformation block at least once even if there is no parent"
	doWhileTrue: [
		| hasParent |
		hasParent := aCurrentElement hasParent.
		hasParent ifTrue: [ aCurrentElement := aCurrentElement parent ].
		hasParent ].

	^ aBounds