Extension { #name : #XMLNode }

{ #category : #'*Bloc-SVG' }
XMLNode >> inheritAttributes [
	"Does nothing if not an XMLNodeElement"
]

{ #category : #'*Bloc-SVG' }
XMLNode >> readElementBy: aSVGFactory withParent: anElement [
	"Do nothing if not an XMLNodeElement"

	^ nil
]

{ #category : #'*Bloc-SVG' }
XMLNode >> splitStyleAttribute [
	"Does nothing if not an XMLNodeElement"
]
