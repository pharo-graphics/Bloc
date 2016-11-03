private
invalidateDuring: aBlock
	"Make sure that the change propagation is not active while executing the parameter."
	isValid ifFalse: [ ^ self ].
	isValid := false.
	aBlock ensure: [ isValid := true ]