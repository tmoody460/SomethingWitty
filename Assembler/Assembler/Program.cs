using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;

namespace Assembler
{
    class Program
    {
        public static  Dictionary<string, int> labelTable;

        static void Main(string[] args)
        {

            StreamReader reader = new StreamReader("C:\\Users\\Tracy\\Desktop\\SampleAssemblyProgram.s");
            StreamWriter writer = new StreamWriter("C:\\Users\\Tracy\\Desktop\\output.mif");

            labelTable = new Dictionary<string, int>();
            
            int lineNumber = 0;
            while (!reader.EndOfStream)
            {
                string line = reader.ReadLine();
                string[] parts = line.Split(new char[] { ',', ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);



                if (parts.Length > 0)
                {
                    if (parts[0].Last() == ':')
                    {
                        string part = parts[0];
                        part = part.Substring(0, part.Length - 1);
                        labelTable.Add(part, lineNumber);
                    }
                }
                                
                lineNumber++;
            }

            reader.DiscardBufferedData();
            reader.BaseStream.Seek(0, SeekOrigin.Begin);
            reader.BaseStream.Position = 0;

            writer.WriteLine("DEPTH: ");
            writer.WriteLine("WIDTH: ");
            writer.WriteLine("ADDRESS_RADIX: ");
            writer.WriteLine("DATA_RADIX: ");
            writer.WriteLine("");
            writer.WriteLine("CONTENT");
            writer.WriteLine("\tBEGIN");
            writer.WriteLine("\t[0..255]\t:\t0000000000000000");

            
            Dictionary<string, string> opCodes = makeOpCodeDictionary();
            Dictionary<string, string> aluCodes = makeALUCodeDictionary();

            lineNumber = 0;

            while (!reader.EndOfStream)
            {
                string line = reader.ReadLine();
                string[] parts = line.Split(new char[] { ',', ' ', '\t', ')', '(' }, StringSplitOptions.RemoveEmptyEntries);
                int startingIndex = parts[0].Last() == ':' ? 1: 0;


                string opCode = opCodes[parts[startingIndex]];
                writer.Write(opCode);

                // http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html
                switch (parts[startingIndex])
                {
                    case "and":
                    case "or":
                    case "xor":
                    case "sll":
                    case "srl":
                    case "add":
                    case "sub":
                    case "slt":
                        writer.Write(convertAndSignExtend(parts[startingIndex+2],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+3],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+1],3));
                        writer.Write(aluCodes[parts[startingIndex]]);
                        break;
                        
                    case "addiu":
                    case "subiu":
                    case "addi":
                    case "subi":
                    case "beq":
                    case "bne":
                        writer.Write(convertAndSignExtend(parts[startingIndex+2],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+1],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+3],6));
                        break;
                    case "lw":
                    case "sw":
                        writer.Write(convertAndSignExtend(parts[startingIndex+3],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+1],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+2],6));
                        break;
                    case "jr":
                    case "jal":
                        writer.Write(convertAndSignExtend(parts[startingIndex+1],3));
                        writer.Write(convertAndSignExtend(parts[startingIndex+2],9));
                        break;
                    case "j":
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 12));
                        break;

                    default:
                        break;
                }

                writer.WriteLine();
                lineNumber++;
            }


            reader.Close();
            writer.Close();
        }

        private static string convertAndSignExtend(string part, int numBits)
        {
            if (part.First() == '$')
            {
                part = part.Substring(1);
            }
            if (labelTable.ContainsKey(part))
            {
                part = labelTable[part].ToString();
            }
            string binary = Convert.ToString(Int32.Parse(part), 2);
            int numberToExtend = numBits - binary.Length;

            for (int i = 0; i < numberToExtend; i++)
            {
                binary = "0" + binary;   
            }
            return binary;
        }
        private static Dictionary<string, string> makeALUCodeDictionary()
        {
            Dictionary<string, string> aluCode = new Dictionary<string, string>();

            aluCode.Add("and", "000");
            aluCode.Add("or", "001");
            aluCode.Add("xor", "010");
            aluCode.Add("sll", "101");
            aluCode.Add("srl", "100");
            aluCode.Add("add", "111");
            aluCode.Add("sub", "110");
            aluCode.Add("slt", "110");


            return aluCode;
        }
        private static Dictionary<string, string> makeOpCodeDictionary()
        {

            Dictionary<string, string> opCode = new Dictionary<string, string>();

            opCode.Add("and", "0000");
            opCode.Add("or","0000");
            opCode.Add("xor","0000");
            opCode.Add("sll", "0000");
            opCode.Add("srl", "0000");
            opCode.Add("add", "0000");
            opCode.Add("sub", "0000");

            opCode.Add("addiu","0110");
            opCode.Add("subiu", "0111");
            opCode.Add("addi","0100");
            opCode.Add( "subi", "0101");

            opCode.Add("j","1001");
            opCode.Add("jr", "1000");
            opCode.Add("jal", "1010");

            opCode.Add("beq", "1100");
            opCode.Add("bne", "1101");
            opCode.Add("slt", "1110");

            opCode.Add("lw", "0010");
            opCode.Add("sw", "0011");
            
            return opCode;

        }
    }
}
