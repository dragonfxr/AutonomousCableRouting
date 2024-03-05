using System;

namespace ZuruJson
{
	public class ElectricalJunction
	{
		public string id;
		public float orientation;
		public JunctionPosition position;

		public ElectricalJunction()
		{
			position = new JunctionPosition();
		}
	}
}

