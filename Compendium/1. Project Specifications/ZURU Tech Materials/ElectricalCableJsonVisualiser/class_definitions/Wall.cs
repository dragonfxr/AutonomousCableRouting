using System;
using System.Collections.Generic;

namespace ZuruJson
{
	public class Wall
	{
		public string id;
		public List<ElectricalCablePaths> electricalCablePaths;
		public List<ElectricalJunction> electricalJunction;

		public Wall()
		{
			electricalCablePaths = new List<ElectricalCablePaths>();
			electricalJunction = new List<ElectricalJunction>();
		}
	}
}

