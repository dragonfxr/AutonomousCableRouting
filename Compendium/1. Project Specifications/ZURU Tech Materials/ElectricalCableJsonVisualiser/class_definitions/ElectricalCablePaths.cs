using System;
using System.Collections.Generic;

namespace ZuruJson
{
	public class ElectricalCablePaths
	{
		public string id;
		public string wireType;
		public float length;
		public List<Segment> segments;
		public ElectricalCablePaths()
		{
			segments = new List<Segment>();
		}
	}
}
