Class {
	#name : #GToolkitImagesExamples,
	#superclass : #Object,
	#category : #'Bloc-Images-Examples'
}

{ #category : #examples }
GToolkitImagesExamples >> gridElementForDirectory: aFileReference [
	"Answer an element that displays the images in aFileReference in a grid"

	| gridElement scrollPane jpgs previewSize children |

	gridElement := BlElement new.
	gridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	gridElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	jpgs := aFileReference asFileReference children sorted
		select: [ :each | each extension asLowercase = 'jpg' ].
	previewSize := 200@200.
	children :=  jpgs collect: [ :file |
			BlFileImageElement new 
				size: previewSize;
				file: file;
				yourself ].
	children size >= 5 ifTrue:
		[ (children at: 5) priority: 0 ].

	gridElement addChildren: children.
	scrollPane := BlScrollableElement new.
	scrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollPane addChild: gridElement.

	^scrollPane
]

{ #category : #examples }
GToolkitImagesExamples >> gridSpaceForDirectory: aFileReference [
	"Open a BlSpace that displays the images in aFileReference in a grid"

	| scrollPane space |

	scrollPane := self gridElementForDirectory: aFileReference.

	space := BlSpace new.
	space root addChild: scrollPane.
	space title: 'Gallery on: ', aFileReference asFileReference pathString.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> gtBlUrlImageElement [
	<gtExample>

	| file element |

	file := GtIcebergUtility resourceAtPath: Path * 'feenkcom' / 'gtoolkit-inspector' /' doc' / 'gt.png'.
	element := BlFileImageElement file: file.
	^element
]

{ #category : #examples }
GToolkitImagesExamples >> gtBlUrlImageSpace [
	<gtExample>

	| space |

	space := BlSpace new.
	space root addChild: self gtBlUrlImageElement.
	space title: 'GT Logo' translated.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> imageInSpace: aFileReference [

	| element space |

	element := BlFileImageElement new.
	element file: aFileReference asFileReference.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	space := BlSpace new.
	space root addChild: element.
	space title: aFileReference asFileReference basename.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> urlGrid [
	<gtExample>
	<noTest>

	| images gridElement scrollPane space previewSize children |

	images := STONJSON fromString: 'https://unsplash.it/list' asUrl retrieveContents.

	gridElement := BlElement new.
	gridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	gridElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	previewSize := 200@200.
	children := OrderedCollection new.
	30 timesRepeat: [ 
		children add: (BlUrlImageElement new 
			size: previewSize;
			url: 'https://unsplash.it/200/100?image=', (images atRandom at: 'id') asString) ].

	gridElement addChildren: children.
	scrollPane := BlScrollableElement new.
	scrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollPane addChild: gridElement.

	space := BlSpace new.
	space root addChild: scrollPane.
	space title: 'Gallery thanks to https://unsplash.it'.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> urlImageInSpace [
	<gtExample>

	| url element space |

	url := 'https://picsum.photos/200/100'.

	element := BlUrlImageElement url: url.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	space := BlSpace new.
	space root addChild: element.
	space title: url.
	space show.
	^space
]
