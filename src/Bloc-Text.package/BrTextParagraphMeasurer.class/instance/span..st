span - accessing
span: aBrSpan
	| aBlTransformation |
	"Set text span that should be measured"

	span := aBrSpan.

	"As soon as we set new span we should recompute transformation matrix"
	aBlTransformation := self class matrix loadIdentity.
	span attributes do: [ :anAttribute | anAttribute applyOnTransformation: aBlTransformation with: span ].
	self transformation: aBlTransformation.