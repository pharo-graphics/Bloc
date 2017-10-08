converting
asMatrixCollection
	^ Matrix
		rows: 4
		columns: 4
		contents: {
			sx . shx0 . shx1 . x .
			shy0 . sy . shy1 . y .
			shz0 . shz1 . sz . z .
			wx . wy . wz . w
		}