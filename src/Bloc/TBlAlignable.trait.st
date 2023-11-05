"
I add alignment api in both axis simultaneously.

My users are layout related classes
"
Trait {
	#name : 'TBlAlignable',
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : 'api - alignment' }
TBlAlignable >> alignBottomCenter [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : 'api - alignment' }
TBlAlignable >> alignBottomLeft [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : 'api - alignment' }
TBlAlignable >> alignBottomRight [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : 'api - alignment' }
TBlAlignable >> alignCenter [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : 'api - alignment' }
TBlAlignable >> alignCenterLeft [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : 'api - alignment' }
TBlAlignable >> alignCenterRight [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : 'api - alignment' }
TBlAlignable >> alignNone [
	self verticalAlignment: BlElementAlignment vertical null.
	self horizontalAlignment: BlElementAlignment horizontal null
]

{ #category : 'api - alignment' }
TBlAlignable >> alignTopCenter [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : 'api - alignment' }
TBlAlignable >> alignTopLeft [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : 'api - alignment' }
TBlAlignable >> alignTopRight [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : 'accessing' }
TBlAlignable >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self explicitRequirement
]

{ #category : 'accessing' }
TBlAlignable >> horizontalAlignment: aBlElementAlignment [
	self explicitRequirement
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignBottomCenter [

	^ self verticalAlignment = BlElementAlignment vertical end and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal center ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignBottomLeft [

	^ self verticalAlignment = BlElementAlignment vertical end and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal start ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignBottomRight [

	^ self verticalAlignment = BlElementAlignment vertical end and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal end ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignCenter [

	^ self verticalAlignment = BlElementAlignment vertical center and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal center ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignCenterLeft [

	^ self verticalAlignment = BlElementAlignment vertical center and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal start ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignCenterRight [

	^ self verticalAlignment = BlElementAlignment vertical center and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal end ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignNone [

	^ self verticalAlignment = BlElementAlignment vertical null and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal null ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignTopCenter [

	^ self verticalAlignment = BlElementAlignment vertical start and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal center ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignTopLeft [

	^ self verticalAlignment = BlElementAlignment vertical start and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal start ]
]

{ #category : 'api - alignment' }
TBlAlignable >> isAlignTopRight [

	^ self verticalAlignment = BlElementAlignment vertical start and: [ 
		  self horizontalAlignment = BlElementAlignment horizontal end ]
]

{ #category : 'accessing' }
TBlAlignable >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self explicitRequirement
]

{ #category : 'accessing' }
TBlAlignable >> verticalAlignment: aBlElementAlignment [
	self explicitRequirement
]
