package testsuit
{
	import net.digitalprimates.fluint.tests.TestSuite;
	
	import org.unitTests.test.DellMeTestCase;

	public class AsyncUtilsTestSuit extends TestSuite
	{
		public function AsyncUtilsTestSuit()
		{
			super();
			addTestCase(new DellMeTestCase());
		}
		
	}
}