drawing
drawChildrenOnSpartaCanvas: aCanvas

	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas ]
		during: [ self children sortedByElevation
			do: [ :anElement |
				"we intentionally compare with direct reference;
				if fromHead does not exist (is nil) identity comparison will return false anyway"
				(anElement == fromHead or: [ anElement == toHead ])
					ifFalse: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ] ]