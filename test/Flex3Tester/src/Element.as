package 
{
	public class Element 
	{
		public var attribute1:String;
		public var attribute2:int;
		public var attribute3:Boolean;
		public var attribute4:Date;
		
		public function Element(attribute1:String, attribute2:int, attribute3:Boolean, attribute4:Date) 
		{
			this.attribute1 = attribute1;
			this.attribute2 = attribute2;
			this.attribute3 = attribute3;
			this.attribute4 = attribute4;
		}
		
		public function toString():String
		{
			return "Element = " + attribute1 + ", " + attribute2 + ", " + attribute3;
		}
	}
}