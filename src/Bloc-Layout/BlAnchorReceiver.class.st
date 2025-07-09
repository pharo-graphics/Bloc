Class {
	#name : #BlAnchorReceiver,
	#superclass : #Object,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #'layout anchors' }
BlAnchorReceiver >> actionAnchor: aBlock [

	^ BlActionAnchor new
		  action: aBlock;
		  baseAnchor: self nilAnchor;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> bottomAnchor [

	^ BlElementBottomAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> bottomLeftAnchor [

	^ BlElementBottomLeftAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> bottomRightAnchor [

	^ BlElementBottomRightAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> centerAnchor [

	^ BlElementCenterAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> extentAnchor [

	^ BlElementExtentAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> heightAnchor [

	^ BlElementHeightAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> horizontalCenterAnchor [

	^ BlElementHorizontalCenterAnchor new
		  receiver: self;
		  yourself
]

{ #category : #initialization }
BlAnchorReceiver >> inParent: anElement forChild: aChild [

	^ self
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> leftAnchor [

	^ BlElementLeftAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> neutralAnchor: aNeutralValue [

	^ BlNeutralAnchor new
		  neutralValue: aNeutralValue;
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> nilAnchor [

	^ self neutralAnchor: nil
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> perimeterAnchor [

	^ BlElementPerimeterAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> pointAnchor [ 

	^ BlElementPointAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> rightAnchor [

	^ BlElementRightAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> topAnchor [

	^ BlElementTopAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> topLeftAnchor [

	^ BlElementTopLeftAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> topRightAnchor [

	^ BlElementTopRightAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> verticalCenterAnchor [

	^ BlElementVerticalCenterAnchor new
		  receiver: self;
		  yourself
]

{ #category : #'layout anchors' }
BlAnchorReceiver >> widthAnchor [

	^ BlElementWidthAnchor new
		  receiver: self;
		  yourself
]
