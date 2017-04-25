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

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:16:34'!
assertBlock: aBlockClosure expectException: aExceptionExpected blocksToAssert: aBlockToAssert
	"assert a block closure expecting an exception with post validations"
				
	[ aBlockClosure value.
	self fail ]
		on: aExceptionExpected 
		do: [ :anError | 
			aBlockToAssert do: [:assertBlock | self assert: (assertBlock value: anError ) ]].
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:17:33'!
assertBlock: aBlockClosure shouldNotTakeMoreThan: aDuration
	"execute a block and assert that runs before a duration time"
	
     aBlockClosure durationToRun < aDuration.	
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:05:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assertBlock: [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreThan: (Duration milliSeconds: 50)! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:05:27'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertBlock: [customerBook removeCustomerNamed: paulMcCartney.] shouldNotTakeMoreThan: (Duration milliSeconds: 100)  
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:18:47'!
test03CanNotAddACustomerWithEmptyName

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertBlock: [customerBook addCustomerNamed: ''] 
		expectException: Error 
		blocksToAssert: (Array with: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage] 
                                                 with: [:anError | customerBook isEmpty]).! !

!IdiomTest methodsFor: 'testing' stamp: 'Masch 4/25/2017 07:18:41'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertBlock: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		expectException: NotFound 
		blocksToAssert: (Array with: [:anError | customerBook numberOfCustomers = 1] 
                                                 with: [:anError | customerBook includesCustomerNamed: johnLennon] )! !

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
