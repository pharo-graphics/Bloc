private
validateChildConstraints: aChildElement
	| childConstraints |
	childConstraints := aChildElement constraints grid.
	"we need to convert match parent mode to something that fits grid layout"
	aChildElement constraints horizontal resizer
		ifMatchParent: [
			childConstraints horizontal spec weight isZero
				ifTrue: [ childConstraints horizontal weight: 1 ].
			childConstraints horizontal specAlignment: BlGridAlignment fill ].
	
	aChildElement constraints vertical resizer
		ifMatchParent: [
			childConstraints vertical spec weight isZero
				ifTrue: [ childConstraints vertical weight: 1 ].
			childConstraints vertical specAlignment: BlGridAlignment fill ]