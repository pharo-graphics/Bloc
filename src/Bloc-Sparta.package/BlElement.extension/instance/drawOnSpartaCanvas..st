*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	| isBackgroundTransparent isBorderTransparent areBothTransparent areBothVisible |

	isBackgroundTransparent := background isTransparent.
	isBorderTransparent := border isTransparent.
	areBothTransparent := isBackgroundTransparent and: [ isBorderTransparent ].
	areBothVisible := (isBackgroundTransparent or: [ isBorderTransparent ]) not.

	areBothTransparent
		ifTrue: [ ^ self ].

	"We create a new virtual layer in order to blend background and border only if they are both visible"
	aCanvas layer
		when: [ areBothVisible ]
		during: [ self border "is it border's responsibility?"
			drawBackground: [ self drawBackgroundOnSpartaCanvas: aCanvas ]
			border: [ self drawBorderOnSpartaCanvas: aCanvas ]
			of: self
			onSpartaCanvas: aCanvas ]