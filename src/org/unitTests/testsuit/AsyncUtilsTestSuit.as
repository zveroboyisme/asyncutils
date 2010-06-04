package org.unitTests.testsuit
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	import org.unitTests.test.BindingExecutorInitTestCase;

	public class AsyncUtilsTestSuit extends TestSuite
	{
		public function AsyncUtilsTestSuit()
		{
			super();
			addTestCase(new BindingExecutorInitTestCase());
		}
		
	}
}