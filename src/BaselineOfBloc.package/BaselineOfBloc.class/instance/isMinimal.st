private
isMinimal
	"Return true if we are loading a minimal version with manually selected packages"
	<return: #Boolean>

	^ self hasDirective
		and: [ self directive = #minimal ]