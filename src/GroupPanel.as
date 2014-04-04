package
{
	import mx.containers.Canvas;
	import mx.controls.Button;
	
	public class GroupPanel extends Canvas
	{
		
		public var oKB:Button = new Button();
		public var CB:Button = new Button();
		
		public function GroupPanel()
		{
			
			this.setStyle("backgroundColor","#979795"); 
			this.setStyle("borderStyle","solid");
			this.width = 175;
			this.height = 400;
			this.x = 400;
			this.y = -600;
			
		}
	}
}