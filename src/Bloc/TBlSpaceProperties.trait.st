"
I define interface for accessing space properties such as title, extent, borderless, fullscreen, position.
I must be implemented by all host spaces for window specific implementation.

By using this Trait in both Space and HostSpace we make sure that they have the same uniform API
"
Trait {
	#name : #TBlSpaceProperties,
	#category : #'Bloc-Space'
}

{ #category : #'window - properties' }
TBlSpaceProperties >> borderless: aBoolean [
	"Make host window borderless if true is given"

	self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given and exit fullscreen mode if false is given"

	self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given and exit fullsize mode if false is given.
	See `TBlSpaceProperties>>#fullsize`"

	self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> icon: aForm [
	"Change window's icon to the given one"
	
	self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise"

	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> isFullsize [
	"Return true if an underlying window is in fullsize mode, false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent and has no window title."

	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> isResizable [
	"Return true if underlying window is resizable, false otherwise"

	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> position [
	"Return window's position in screen coordinates (`Point`)"
	
	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	self explicitRequirement

]

{ #category : #'window - properties' }
TBlSpaceProperties >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> title [
	"Return window's title (`String`)"

	^ self explicitRequirement
]

{ #category : #'window - properties' }
TBlSpaceProperties >> title: aString [
	"Change window's title"

	self explicitRequirement
]
