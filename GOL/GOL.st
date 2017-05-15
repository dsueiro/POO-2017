!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/12/2017 23:49:53'!
test06CannotAddAliveCellWithRowGreaterThanMaxRow
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/12/2017 23:51:19'!
test07CannotAddAliveCellWithColumnGreaterThanMaxColumn
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 4@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/12/2017 23:52:54'!
test08CannotAddAliveCellWithNegativeRow
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@(-1) } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/12/2017 23:53:46'!
test09CannotAddAliveCellWithNegativeColumn
	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. (-1)@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/14/2017 13:19:08'!
test10CannotAddAliveCellWithNonIntegerColumn
	self 
		should: [ GameOfLife withLiveCells: { 1.1@0 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'testing' stamp: 'DHS 5/14/2017 13:22:50'!
test11CannotAddAliveCellWithNonIntegerRow
	self 
		should: [ GameOfLife withLiveCells: { 1@1.1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !


!classDefinition: #CellState category: #GOL!
Object subclass: #CellState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CellState class' category: #GOL!
CellState class
	instanceVariableNames: ''!

!CellState class methodsFor: 'state selection' stamp: 'masch 5/15/2017 06:12:48'!
canHandle: aCell in: aGameOfLife

	self subclassResponsibility ! !

!CellState class methodsFor: 'state selection' stamp: 'PEP 5/14/2017 23:16:01'!
stateFor: aCell in: aGameOfLife
	
	^self allSubclasses detect: [:aCellStateClass | aCellStateClass canHandle: aCell in: aGameOfLife]! !


!classDefinition: #AliveCellState category: #GOL!
CellState subclass: #AliveCellState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!AliveCellState methodsFor: 'cell generation' stamp: 'masch 5/15/2017 06:17:17'!
is: aCell aliveInNextGenerationIn: aGameOfLife

	^aGameOfLife hasToSurvive: aCell! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AliveCellState class' category: #GOL!
AliveCellState class
	instanceVariableNames: ''!

!AliveCellState class methodsFor: 'as yet unclassified' stamp: 'PEP 5/14/2017 23:19:06'!
canHandle: aCell in: aGameOfLife

	^aGameOfLife isAliveAt: aCell! !


!classDefinition: #DeadCellState category: #GOL!
CellState subclass: #DeadCellState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!DeadCellState methodsFor: 'cell generation' stamp: 'masch 5/15/2017 06:17:24'!
is: aCell aliveInNextGenerationIn: aGameOfLife

	^aGameOfLife hasToResurrect: aCell! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DeadCellState class' category: #GOL!
DeadCellState class
	instanceVariableNames: ''!

!DeadCellState class methodsFor: 'as yet unclassified' stamp: 'PEP 5/14/2017 23:19:43'!
canHandle: aCell in: aGameOfLife

	^aGameOfLife isDeadAt: aCell! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'public' stamp: 'masch 5/15/2017 06:32:19'!
nextGeneration
	
	aliveCells := self gameCells select: [:aCell | ((self cellStateFor: aCell) is: aCell aliveInNextGenerationIn: self)]! !


!GameOfLife methodsFor: 'private' stamp: 'masch 5/15/2017 06:22:52'!
cellStateFor: aCell

	^(CellState stateFor: aCell in: self) new
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

!GameOfLife methodsFor: 'private' stamp: 'PEP 5/15/2017 00:21:58'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'private' stamp: 'masch 5/15/2017 06:54:45'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours |
	
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


!GameOfLife methodsFor: 'initialization' stamp: 'masch 5/14/2017 20:32:22'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'validation' stamp: 'masch 5/15/2017 07:58:39'!
validateCell: aCell withSize: aSize

	^(self validateColumn: aCell withSize: aSize) and: [self validateRow: aCell withSize: aSize].
! !

!GameOfLife class methodsFor: 'validation' stamp: 'masch 5/15/2017 08:07:06'!
validateCells: aCollectionOfCells withSize: aSize

	(aCollectionOfCells allSatisfy: [:aCell | 
		self validateCell: aCell withSize: aSize]) ifFalse: [ self error: 'celda fuera de rango' ].! !

!GameOfLife class methodsFor: 'validation' stamp: 'masch 5/15/2017 08:07:59'!
validateColumn: aCell withSize: upperTopPoint

	^self validateCoordinate: aCell x withMaxValue: upperTopPoint x.
! !

!GameOfLife class methodsFor: 'validation' stamp: 'masch 5/15/2017 08:07:46'!
validateCoordinate: aCoordinate withMaxValue: maxValue

	^(aCoordinate isKindOf: Integer) and: [aCoordinate between: 0 and: maxValue]! !

!GameOfLife class methodsFor: 'validation' stamp: 'masch 5/15/2017 08:07:50'!
validateRow: aCell withSize: upperTopPoint

	^self validateCoordinate: aCell y withMaxValue: upperTopPoint y.! !


!GameOfLife class methodsFor: 'instance creation' stamp: 'masch 5/15/2017 08:06:06'!
withLiveCells: aCollectionOfAliveCells withSize: upperTopPoint 
	
	self validateCells: aCollectionOfAliveCells withSize: upperTopPoint.
	
	^self new initializeWith: aCollectionOfAliveCells withSize: upperTopPoint ! !
