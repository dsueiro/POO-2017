!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/23/2017 13:27:26'!
assertBlock: aBlockClosure expectException: aExceptionExpected blocksToAssert: aBlockToAssert
				
	[ aBlockClosure value.
	self fail ]
		on: aExceptionExpected 
		do: [ :anError | 
			aBlockToAssert do: [:assertBlock | self assert: assertBlock ]].
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/23/2017 13:33:58'!
assertBlock: aBlockClosure expectException: aExceptionExpected expectMessageText: anExpectedMessageText blocksToAssert: aBlockToAssert
				
	[ aBlockClosure value.
	self fail ]
		on: aExceptionExpected 
		do: [ :anError | 
			self assert: anExpectedMessageText = anError messageText.
			aBlockToAssert do: [:assertBlock | self assert: assertBlock ]].
! !

!IdiomTest methodsFor: 'testing' stamp: 'mario 4/20/2017 21:31:47'!
assertBlock: aBlockClosure runsFasterThanMilliseconds: milliseconds 
	| stopWatch |
	  
	stopWatch := StopWatch new.
	
	self assert: (stopWatch millisecondsEllapsed: aBlockClosure ) < milliseconds.
! !

!IdiomTest methodsFor: 'testing' stamp: 'Mario Chacon 4/23/2017 11:53:29'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assertBlock: [customerBook addCustomerNamed: 'John Lennon'.] runsFasterThanMilliseconds: 50! !

!IdiomTest methodsFor: 'testing' stamp: 'mario 4/20/2017 21:32:43'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertBlock: [customerBook removeCustomerNamed: paulMcCartney.] runsFasterThanMilliseconds: 100  
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/23/2017 12:10:17'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/23/2017 13:34:30'!
test03CanNotAddACustomerWithEmptyName2

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertBlock: [customerBook addCustomerNamed: ''] 
		expectException: Error 
		expectMessageText: CustomerBook customerCanNotBeEmptyErrorMessage
		blocksToAssert: (OrderedCollection with: [customerBook isEmpty]).! !

!IdiomTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/16/2012 16:50'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/23/2017 13:27:58'!
test04CanNotRemoveAndInvalidCustomer2
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertBlock: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		expectException: NotFound 
		blocksToAssert: (OrderedCollection with: [customerBook numberOfCustomers = 1] 
													    with: [customerBook includesCustomerNamed: johnLennon] )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IdiomTest class' category: #'Idiom-Exercise'!
IdiomTest class
	instanceVariableNames: 'assert test01AddingCustomerShouldNotTakeMoreThan50Milliseconds2 test06 customerBook'!


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !


!classDefinition: #StopWatch category: #'Idiom-Exercise'!
Object subclass: #StopWatch
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!StopWatch methodsFor: 'as yet unclassified' stamp: 'mario 4/20/2017 21:21:17'!
millisecondsEllapsed: aClosure
	"comment stating purpose of message"

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.

	^ millisecondsAfterRunning - millisecondsBeforeRunning.! !
