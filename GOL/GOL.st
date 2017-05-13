!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:49:53'!
test06CannotAddAliveCellWithRowGreaterThanMaxRow
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:51:19'!
test07CannotAddAliveCellWithColumnGreaterThanMaxColumn
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 4@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:52:54'!
test08CannotAddAliveCellWithNegativeRow
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@(-1) } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:53:46'!
test09CannotAddAliveCellWithNegativeColumn
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. (-1)@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:58:23'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells.
	! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'DHS 5/13/2017 00:16:51'!
nextGeneration
	
	aliveCells := self gameCells select: [:aCell | (self isAliveAt: aCell) 
			ifTrue: [self hasToSurvive: aCell ]
			ifFalse: [self hasToResurrect: aCell]
	]
! !


!GameOfLife methodsFor: 'private' stamp: 'DHS 5/13/2017 00:12:06'!
deadCells
	
	^self gameCells select: [:cell| self isDeadAt: cell]
! !

!GameOfLife methodsFor: 'private' stamp: 'DHS 5/13/2017 00:10:11'!
gameCells
	
	| gameCells |
	
	gameCells _ Set new.
	0 to: size x do: [ :x |
		0 to: size y do: [ :y |
			gameCells add: x@y]].
	^gameCells ! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'private' stamp: 'DHS 5/13/2017 00:06:24'!
isAliveAt: aCell

	^aliveCells includes: aCell! !

!GameOfLife methodsFor: 'private' stamp: 'DHS 5/13/2017 00:06:52'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'DHS 5/12/2017 23:58:09'!
withLiveCells: aCollectionOfAliveCells withSize: upperTopPoint 

	(aCollectionOfAliveCells allSatisfy: [:aCell |
		(aCell x between: 0 and: upperTopPoint x) and: [ aCell y between: 0 and: upperTopPoint y]]) ifFalse: [ self error: 'celda fuera de rango' ].
	
	^self new initializeWith: aCollectionOfAliveCells withSize: upperTopPoint ! !
