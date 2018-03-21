instance creation
createCanvas: anExtent
	| aCanvas |

	aCanvas := Bloc preferableSpartaCanvas extent: anExtent.
	
	"make sure that canvas has a background color, because JPG does not support transparency"
	aCanvas fill
		paint: self backgroundColor;
		path: aCanvas bounds;
		draw.

	^ aCanvas