package org.unitTests.test
{
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import org.asyncutils.BindingExecutor;

	public class BindingExecutorInitTestCase extends TestCase
	{
		private var _bindingExecutor:BindingExecutor;
		private var _timer:Timer;

		private static const ASYNC_CONDITIONS_MET:String = "AsyncConditionsMet";

		public function BindingExecutorInitTestCase()
		{
			super();
		}

		override protected function setUp():void
		{
			super.setUp();
			//_timer = new Timer(1000, 1);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			if (_bindingExecutor)
			{
				//_bindingExecutor.stopWatching();
			}
			_bindingExecutor = null;
			//_timer.reset();
			//_timer = null;
		}

		public function testConstructorProtection():void
		{
			try
			{
				var executor:BindingExecutor = new BindingExecutor();
				fail("Direct invocation of Binding Executor constructor should've failed!");
			}
			catch (e:Error)
			{
				assertTrue(true);
			}
		}

		public function testSimple():void
		{
			var a:DellMeA = new DellMeA();

			function testFunction(value:String):Boolean
			{
				trace(" testFunction value: " + value);
				return value == "Async";
			}
			
			function testFunctionNum(value:Number):Boolean
			{
				trace(" testFunctionNum value: " + value);
				return value == 25;
			}


			_bindingExecutor = BindingExecutor.execute(executeOnEquals).once(testFunction, a, ["dellMeB", "str"]).once(testFunctionNum, a, "num");

			this.addEventListener(ASYNC_CONDITIONS_MET, asyncHandler(onConditionsMet, 1000, new Date(), timeoutHandler));
			setTimeout(function():void
				{
					trace(" setting dellmeb.str to Async ");
					a.dellMeB.str = "Async"
				}, 100);

			setTimeout(function():void
				{
					trace(" setting dellmeA.num to 25 ");
					a.num = 25
				}, 200);
			_bindingExecutor.startWatching();
		}

		private function executeOnEquals():void
		{
			this.dispatchEvent(new Event(ASYNC_CONDITIONS_MET));
		}


		private function onConditionsMet(event:Event, passThruData:Object):void
		{
			assertTrue("Binding Executor executed", true);
			var time:Number = new Date().time;
			
			var startTime:Number = (passThruData as Date).time;
			
			assertTrue(" Executed too early " , (time - startTime) >= 200);
		}

		private function timeoutHandler(passThruData:Object):void
		{
			fail("Binding Executor didn't execute");
		}


		public function testGettingValueOfObjectChain():void
		{
			var dellMeA:DellMeA = new DellMeA();
			var chain:Array = ["dellMeB", "str"];

			var property:* = dellMeA;

			for each (var propName:String in chain)
			{
				property = property[propName];
			}

			assertTrue(property == new DellMeB().str);
		}

	}
}