as yet unclassified
importIn: aClass fromDir: aString
	self
		createIconClass:aClass withIcons:
			(aString asFileReference entries
				collect: [ :each | 
					(XMLDOMParser parseFileNamed: each fullName) root allNodes
						detect: [ :n | n isElementNamed: #path ]
						ifFound: [ :n | 
							(self iconNameFromFileName: each basename)
								-> ((self categoryNameFromFileName: each basename) -> (n attributeAt: #d)) ]
						ifNone: [ nil ] ])