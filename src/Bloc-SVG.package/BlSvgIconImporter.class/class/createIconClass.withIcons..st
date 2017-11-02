as yet unclassified
createIconClass: aClass withIcons: aCollection
	aCollection
		do: [ :assoc | 
			assoc
				ifNotNil: [ aClass class
						compile: assoc key , 'Src' , String cr , '^''' , assoc value value , ''''
						classified: assoc value key.
					aClass class
						compile: assoc key , 'Svg' , String cr , '^ BlSvgPath fromStream: self ' , assoc key , 'Src'
						classified: assoc value key.
					aClass class
						compile: assoc key , 'Icon' , String cr , '^ self ',assoc key , 'Svg asElement'
						classified: assoc value key ] ]