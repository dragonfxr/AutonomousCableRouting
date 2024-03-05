using System;
using System.Collections.Generic;

namespace ZuruJson
{
	public class Segment
	{
		public string id;
		public bool line;
		public List<CablePoint> points;

		public Segment()
		{
			points = new List<CablePoint>();
		}
	}
}
