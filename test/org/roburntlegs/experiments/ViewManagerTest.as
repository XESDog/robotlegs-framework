package org.roburntlegs.experiments {

	import asunit.framework.TestCase;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ViewManagerTest extends TestCase {
		private var instance:ViewManager;  
		protected var _firstCallbackCalled:Boolean; 
		protected var _secondCallbackCalled:Boolean; 
		protected static const RELEVANT_EVENT:String = "SomeEvent";
		protected static const SECOND_RELEVANT_EVENT:String = RELEVANT_EVENT + "fhdjskhfsfdsfds";
		protected static const IRRELEVANT_EVENT:String = RELEVANT_EVENT + SECOND_RELEVANT_EVENT + "fhdjkshds";
		protected var _correctTarget:IEventDispatcher;
		protected var _secondCorrectTarget:IEventDispatcher;
		protected var _incorrectTarget:IEventDispatcher;

		public function ViewManagerTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();                    
			_firstCallbackCalled = false;
			_secondCallbackCalled = false;
			_correctTarget = new EventDispatcher();
			_secondCorrectTarget = new EventDispatcher();
			_incorrectTarget = new EventDispatcher();  
			instance = new ViewManager();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is ViewManager", instance is ViewManager);
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}                                  

		public function test_addInterestIn_event_triggers_two_passed_callbacks_after_relevant_event_on_correct_target():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, secondCallback);                                
			_correctTarget.dispatchEvent(new Event(RELEVANT_EVENT));
			assertTrue("Both callbacks called", _firstCallbackCalled && _secondCallbackCalled);
		}     
		
		public function test_addInterestIn_event_triggers_two_passed_callbacks_after_relevant_events_on_correct_target():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			instance.addInterestIn(_secondCorrectTarget, SECOND_RELEVANT_EVENT, secondCallback);                                
			_correctTarget.dispatchEvent(new Event(RELEVANT_EVENT));
			_secondCorrectTarget.dispatchEvent(new Event(SECOND_RELEVANT_EVENT));
			assertTrue("Both callbacks called", _firstCallbackCalled && _secondCallbackCalled);
		}     
		                
		public function test_addInterestIn_event_doesnt_trigger_either_callback_after_relevant_events_on_incorrect_targets():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			instance.addInterestIn(_secondCorrectTarget, SECOND_RELEVANT_EVENT, secondCallback);                                
			_secondCorrectTarget.dispatchEvent(new Event(RELEVANT_EVENT));
			_correctTarget.dispatchEvent(new Event(SECOND_RELEVANT_EVENT));
			assertFalse("Neither callback called", _firstCallbackCalled || _secondCallbackCalled);
		}     
		
		public function test_addInterestIn_event_triggers_passed_callback_after_relevant_event_on_correct_target():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			_correctTarget.dispatchEvent(new Event(RELEVANT_EVENT));
			assertTrue("Callback called", _firstCallbackCalled);
		}  

		public function test_addInterestIn_event_does_not_trigger_passed_callback_after_relevant_event_on_incorrect_target():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
		    _incorrectTarget.dispatchEvent(new Event(RELEVANT_EVENT));
			assertFalse("Callback not called", _firstCallbackCalled);
		}  

		public function test_addInterestIn_event_does_not_trigger_passed_callback_after_irrelevant_event():void { 
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			_correctTarget.dispatchEvent(new Event(IRRELEVANT_EVENT));
			assertFalse("Callback not called", _firstCallbackCalled);
		}  
		
		public function test_addInterest_doesnt_call_interested_callback_after_no_event():void {
			instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			assertFalse("Callback not called", _firstCallbackCalled);
		}
		
		public function test_adding_same_callback_to_same_target_and_event_twice_throws_error():void {
			var testBlock:Function = function():void
			{
				instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
				instance.addInterestIn(_correctTarget, RELEVANT_EVENT, firstCallback);                                
			}
			
			assertThrows(ArgumentError, testBlock);
		}

		

				
		protected function firstCallback():void
		{
			_firstCallbackCalled = true;
		}

		protected function secondCallback():void
		{
			_secondCallbackCalled = true;
		}
		
		//****************
		
		
		//******************
		
	}
}