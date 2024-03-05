using System;
using System.IO;

using Newtonsoft.Json;

using ZuruJson;

namespace ElectricalCableJsonVisualiser
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            string text = File.ReadAllText("Wall_6.json");

            //Console.WriteLine(text);

            Wall deserialisedWall = JsonConvert.DeserializeObject<Wall>(text);
            Console.WriteLine(deserialisedWall.id);
            Console.WriteLine(deserialisedWall.electricalCablePaths.Count);
            Console.WriteLine(deserialisedWall.electricalJunction.Count);
            

            foreach (ElectricalCablePaths cable in deserialisedWall.electricalCablePaths)
            {
                Console.WriteLine(cable.id);
                foreach(Segment segment in cable.segments)
                {
                  //  Console.WriteLine(segment.id);
                }
            }

            foreach(ElectricalJunction junction in deserialisedWall.electricalJunction)
            {
                Console.WriteLine(junction.id + "\t" + "(" + junction.position.x.ToString() + ", " + junction.position.y.ToString() + ")");
            }

        }
    }
}
