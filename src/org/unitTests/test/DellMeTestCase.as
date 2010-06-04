package org.unitTests.test
{
	import net.digitalprimates.fluint.tests.TestCase;

	public class DellMeTestCase extends TestCase
	{
		public function DellMeTestCase()
		{
			super();
		}
		
		
		public function testMath():void {
                var x:int = 5 + 3;
                
                assertEquals( 8, x )
        }
	}
}