Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*Bloc-Extensions' }
BlLayoutCommonConstraints >> gtInfoFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Properties';
		priority: 10;
		items: [ 
			{
				'Horizontal resizer' -> self horizontal resizer.
				'Vertical resizer' -> self vertical resizer.
				'Requested position' -> self position.
				'Margin' -> self margin.
				'Padding' -> self padding.
				'Minimum width' -> self minWidth.
				'Maximum width' -> self maxWidth.
				'Minimum height' -> self minHeight.
				'Maximum height' -> self maxHeight.
				'Ignored by layout' -> self ignoredByLayout.
			}
		];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]
