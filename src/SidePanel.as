package
{
	
	import mx.containers.Canvas;
	import mx.controls.Button;

	public class SidePanel extends Canvas
	{
		public var oKB:Button;
		public var cB:Button;
		public function SidePanel()
		{
			oKB = new Button();
			oKB.label = "Accept";
			oKB.right = 20;
			oKB.bottom = 5;
			this.addElement(oKB);
			
			cB = new Button();
			cB.label = "Cancel";
			cB.bottom = 5;
			this.addElement(cB);
			
			
			this.setStyle("borderStyle","solid");
			this.width = 175;
			this.height = 400;
			this.x = 100;
			this.y = 100;
		}
	}
	

}