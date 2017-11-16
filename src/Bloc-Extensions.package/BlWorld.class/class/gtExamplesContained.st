world menu
gtExamplesContained
	^ GtExampleGroup new
		examples:
			((RPackageOrganizer default packages
				select:
					[ :each | (each name beginsWith: 'Bloc') or: [ each name beginsWith: 'Brick' ] ])
				flatCollect: [ :each | each gtExamplesContained ])