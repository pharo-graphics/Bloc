transformations
apply
	"Replace element's transformation chain with our new one that we just have built"
	| anElementTransformation |

	anElementTransformation := BlElementLocalTransformation with: transformation.
	target transformation: anElementTransformation