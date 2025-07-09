Class {
	#name : #BlAnchor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #comments }
BlAnchor class >> discussionFromMailingList [

"
http://forum.world.st/Making-layouts-using-anchors-td3434242.html

Making layouts using anchors
Hi, 

i hacked morphs a bit to use anchors for laying out the morphs. 

The idea that you can force morph to make one of its edges (left, top, 
bottom, right) 
be dependent from other morph's edge. 

Here an example: 

| window morph morph2 | 

window := StandardWindow labelled: 'foo'. 
window color: Color red. 
morph := Morph new. 

morph anchorLeft: window leftAnchor + (window widthAnchor * 0.5) - 20. 
morph anchorRight: window leftAnchor + (window widthAnchor * 0.5) + 20. 
morph anchorTop: window topAnchor + 20. 
morph anchorBottom: window bottomAnchor - 20. 

morph2 := Morph new. 
morph2 color: Color green. 

morph2 anchorLeft: morph rightAnchor + 10. 
morph2 anchorRight: morph rightAnchor + 50. 
morph2 anchorTop: window topAnchor + 20. 
morph2 anchorBottom: window bottomAnchor - 20. 

window addMorph: morph2. 
window addMorph: morph. 

window openInWorld. 

window extent: 200@200. 


You can of course implement same layout using proportional layouts 
i.e. you can do 

window addMorph: fullFrame: ... 

but note that while its okay for first morph you add , a morph2 left 
edge is actually depending on first morph right edge. 
So, if it will be resized by other means (like stretched by inner 
morph), you won't be able to align sibling accordingly, 
and then you are forced to use table layout or something else. 

What i like about anchors that it reflects the natural way of thinking 
of UI designer i.e. : 'I want this morph to align to window right 
edge'
or 'I want this morph to align to previous morph right edge with 10 
pixels offset'

For example, if i have two morphs, left and right, and i want to put 
my morph in the middle of them to fill the space between them, 
i can simply do: 

middle := Morph new. 

middle anchorLeft: leftMorph rightAnchor + 10. 
middle anchorRight: rightMorph leftAnchor - 10. 

so, you will get a following layout: 

[leftMorph] [ 10 pixels ] [ ... middle morph ..... ] [ 10 pixels ] 
[right morph ] 

with just two lines of code! 

P.S. Of course , anchors are in conflict with layouts, because you 
cannot have both. But some combination of them could still be used. "
]

{ #category : #arithmetic }
BlAnchor >> * aValuable [
	"answer a new anchor, which is a combination of receiver, offset by some value.
	a value could in own turn be anchor "

	^ BlActionAnchor new
		  baseAnchor: self;
		  action: [ :value | value * aValuable value ]
]

{ #category : #arithmetic }
BlAnchor >> + aValuable [
	"answer a new anchor, which is a combination of receiver, offset by some value.
	a value could in own turn be anchor "

	^ BlActionAnchor new
		  baseAnchor: self;
		  action: [ :value | value + aValuable value ]
]

{ #category : #arithmetic }
BlAnchor >> - aValuable [
	"answer a new anchor, which is a combination of receiver, offset by some value.
	a value could in own turn be anchor "

	^ BlActionAnchor new
		  baseAnchor: self;
		  action: [ :value | value - aValuable value ]
]

{ #category : #arithmetic }
BlAnchor >> / aValuable [
	"answer a new anchor, which is a combination of receiver, offset by some value.
	a value could in own turn be anchor "

	^ BlActionAnchor new
		  baseAnchor: self;
		  action: [ :value | value / aValuable value ]
]

{ #category : #applying }
BlAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAnchor >> element [

	^ self subclassResponsibility
]

{ #category : #testing }
BlAnchor >> isMeasurement [

	^ false
]

{ #category : #'instance creation' }
BlAnchor >> on: anAnchor [

	^ BlAnchorLayoutOperation new
		  baseAnchor: self;
		  rightHandSideAnchor: anAnchor;
		  yourself
]

{ #category : #applying }
BlAnchor >> setUpInParent: anElement forChild: aChild [

	self subclassResponsibility 
]

{ #category : #applying }
BlAnchor >> valueInBounds: aBounds [

	^ self subclassResponsibility
]

{ #category : #applying }
BlAnchor >> valueInParent: aParent [

	^ self valueInBounds: (self element measuredBounds inParent: aParent)
]
