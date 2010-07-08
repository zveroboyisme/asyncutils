package org.unitTests.test
{
	import net.digitalprimates.fluint.tests.TestCase;

	import org.asyncutils.BindingExecutor;

	public class BindingExecutorInitTestCase extends TestCase
	{

		public function BindingExecutorInitTestCase()
		{
			super();
		}

		override protected function setUp():void
		{
			super.setUp();
		}

		override protected function tearDown():void
		{
			super.tearDown();
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




	}
}