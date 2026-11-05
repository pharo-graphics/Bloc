"
I am a geometry drawn from the path data of SVG (the `d` attribute of a `path` element), in the coordinates of my element.

The path data is a string of commands, each moving the virtual pen: `M` moves, `L` draws a line, `C` and `Q` draw curves,
`A` draws an arc, `Z` closes the shape, and so on (lowercase letters use relative coordinates).

### Responsibility
- Keep the path string, and parse it each time I am drawn, sending the commands to the Cairo context.
- Use the winding fill rule (the default) or the even-odd one, which decides whether overlapping parts are filled or are holes.

### Collaborators
- `BlSvgPathParser` reads the path string, and `BASvgPathDrawHandler` turns its commands into Cairo calls.
- `BlSvgConverter` creates me for the `path` elements of SVG documents.

### Public API
```
BlSvgPath pathString: 'M50,65 C20,45 5,30 15,15 C25,0 45,5 50,20 C55,5 75,0 85,15 C95,30 80,45 50,65 Z'.
aPath useEvenOddFillRule.
aPath asElement. ""black fill and no border, the default style of SVG""
```
See `BlSvgPath class >> #exampleHeart`, and run `BlSvgPath class >> #scriptFillRules`.

### Implementation Points
- `matchExtent:` is ignored: the path keeps its coordinates. My extent stays the default one (150 x 100), so set the extent of the element yourself.
- `hasCaps` always answers true, so that open paths are stroked correctly.
- `containsPoint:alreadyInGeometryBoundsOf:` answers true for every point of my bounds: hit testing is not precise yet.
- The path string is parsed again at each drawing (see the `#todo` flag in `aeApplyTo:element:`).

**Instance Variables**
- pathString: the SVG path data.
- fillRule: `Winding` or `EvenOdd`.
"
Class {
	#name : #BlSvgPath,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'fillRule',
		'pathString'
	],
	#classVars : [
		'EvenOdd',
		'Winding'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #examples }
BlSvgPath class >> exampleHeart [
	"Answer a heart drawn by an SVG path, in a 100 x 70 area."

	<sampleInstance>
	^ self pathString: 'M50,65 C20,45 5,30 15,15 C25,0 45,5 50,20 C55,5 75,0 85,15 C95,30 80,45 50,65 Z'
]

{ #category : #'class initialization' }
BlSvgPath class >> initialize [

	EvenOdd := #evenOdd.
	Winding := #winding
]

{ #category : #'instance creation' }
BlSvgPath class >> pathString: aString [
	
	^ self new
		pathString: aString;
		yourself
]

{ #category : #script }
BlSvgPath class >> scriptFillRules [
	"Show the two fill rules on a path made of two nested squares drawn in the same direction:
	with the winding rule (the default) the inner square is filled,
	with the even-odd rule it is a hole."

	<script>
	| path |
	path := 'M10,5 L90,5 L90,65 L10,65 Z M30,20 L70,20 L70,50 L30,50 Z'.
	self demoOpen: { 
			(self
				 demoCellFor: (self demoElementFor: (self pathString: path) extent: 100 @ 70)
				 caption: 'useWindingFillRule').
			(self
				 demoCellFor: (self
						  demoElementFor: ((self pathString: path)
								   useEvenOddFillRule;
								   yourself)
						  extent: 100 @ 70)
				 caption: 'useEvenOddFillRule') }
]

{ #category : #converting }
BlSvgPath >> asElement [
	"Answer the default element for this geometry. The answer should comply the SVG default style."

	^ super asElement
		background: Color black;
		border: BlBorder empty;
		yourself
]

{ #category : #'geometry testing' }
BlSvgPath >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	
	self flag: #todo. "refine! should have a boolean flag to deknow if it's filled?"
	
	^ true
]

{ #category : #initialization }
BlSvgPath >> initialize [

	super initialize.

	self useWindingFillRule
]

{ #category : #accessing }
BlSvgPath >> matchExtent: anExtent [
	"Ignored"
]

{ #category : #'instance creation' }
BlSvgPath >> pathString: aString [

	pathString := aString.
	self releaseCache
]

{ #category : #accessing }
BlSvgPath >> useEvenOddFillRule [

	fillRule := EvenOdd
]

{ #category : #accessing }
BlSvgPath >> useWindingFillRule [

	fillRule := Winding
]
