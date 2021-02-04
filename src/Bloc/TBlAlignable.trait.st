"
I add alignment api in both axis simultaneously.

My users are layout related classes
"
Trait {
	#name : #TBlAlignable,
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #'api - alignment' }
TBlAlignable >> alignBottomCenter [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : #'api - alignment' }
TBlAlignable >> alignBottomLeft [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : #'api - alignment' }
TBlAlignable >> alignBottomRight [
	self verticalAlignment: BlElementAlignment vertical end.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : #'api - alignment' }
TBlAlignable >> alignCenter [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : #'api - alignment' }
TBlAlignable >> alignCenterLeft [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : #'api - alignment' }
TBlAlignable >> alignCenterRight [
	self verticalAlignment: BlElementAlignment vertical center.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : #'api - alignment' }
TBlAlignable >> alignNone [
	self verticalAlignment: BlElementAlignment vertical null.
	self horizontalAlignment: BlElementAlignment horizontal null
]

{ #category : #'api - alignment' }
TBlAlignable >> alignTopCenter [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal center
]

{ #category : #'api - alignment' }
TBlAlignable >> alignTopLeft [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal start
]

{ #category : #'api - alignment' }
TBlAlignable >> alignTopRight [
	self verticalAlignment: BlElementAlignment vertical start.
	self horizontalAlignment: BlElementAlignment horizontal end
]

{ #category : #accessing }
TBlAlignable >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self explicitRequirement
]

{ #category : #accessing }
TBlAlignable >> horizontalAlignment: aBlElementAlignment [
	self explicitRequirement
]

{ #category : #accessing }
TBlAlignable >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self explicitRequirement
]

{ #category : #accessing }
TBlAlignable >> verticalAlignment: aBlElementAlignment [
	self explicitRequirement
]
