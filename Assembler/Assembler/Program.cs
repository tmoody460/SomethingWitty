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
        private static Dictionary<string, int> labelTable;
        static void Main(string[] args)
        {

            StreamReader reader = new StreamReader("C:\\Users\\Tracy\\Desktop\\SampleAssemblyProgram.s");
            StreamWriter writer = new StreamWriter("C:\\Users\\Tracy\\Desktop\\output.mif");

            labelTable = makeLabelTable(reader);
            Dictionary<string, string> opCodes = makeOpCodeDictionary();

            reader.DiscardBufferedData();
            reader.BaseStream.Seek(0, SeekOrigin.Begin);
            reader.BaseStream.Position = 0;

            try
            {
                checkAssemblyIsValid(reader, opCodes);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.Read();
            }

            reader.DiscardBufferedData();
            reader.BaseStream.Seek(0, SeekOrigin.Begin);
            reader.BaseStream.Position = 0;

            writeOutputFile(reader, writer);

            reader.Close();
            writer.Close();
        }

        private static void checkAssemblyIsValid(StreamReader reader, Dictionary<string, string> opCodes)
        {
            int lineNumber = 1;
            while (!reader.EndOfStream)
            {
                string line = reader.ReadLine();
                string[] colonSplitParts = line.Split(':');

                if (colonSplitParts.Length > 2)
                {
                    throw new Exception("Syntax error near : on line " + lineNumber);
                }else if(colonSplitParts.Length == 2){
                    line = colonSplitParts[1];
                }

                line.Trim();
                string[] spaceSplitParts = line.Split(new char[] { '\t', ' ' }, StringSplitOptions.RemoveEmptyEntries);

                if (spaceSplitParts.Length > 2)
                {
                    throw new Exception("Syntax error near ' ' on line " + lineNumber);
                }
                else if (spaceSplitParts.Length == 1)
                {
                    throw new Exception("Syntax error missing ' ' on line " + lineNumber);
                }

                string instruction = spaceSplitParts[0];
                string allArguments = spaceSplitParts[1];

                string[] arguments = allArguments.Split(new char[] { ',', ' '}, StringSplitOptions.RemoveEmptyEntries);
                
                switch (instruction)
                {
                    case "and":
                    case "or":
                    case "xor":
                    case "sll":
                    case "srl":
                    case "add":
                    case "sub":
                    case "slt":
                        if (arguments.Length == 3)
                        {
                            validateRegister(arguments[0], lineNumber, true);
                            validateRegister(arguments[1], lineNumber, false);
                            validateRegister(arguments[2], lineNumber, false);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }
                        break;
                    case "addiu":
                    case "subiu":
                    case "addi":
                    case "subi":
                    case "beq":
                    case "bne":
                        if (arguments.Length == 3)
                        {
                            validateRegister(arguments[0], lineNumber, false);
                            validateRegister(arguments[1], lineNumber, false);
                            validateImmediate(arguments[2], 6, lineNumber);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }
                        break;
                    case "lw":
                        if (arguments.Length == 2)
                        {
                            validateRegister(arguments[0], lineNumber, true);
                            if (arguments[1].Last() != ')')
                            {
                                throw new Exception("Syntax error missing ')' on line " + lineNumber);
                            }
                            string[] addressParts = arguments[1].Split(new char[] {')', '('}, StringSplitOptions.RemoveEmptyEntries);
                            if (addressParts.Length != 2)
                            {
                                throw new Exception("Syntax error on second argument on line " + lineNumber);
                            }
                            validateRegister(addressParts[1], lineNumber, false);
                            validateImmediate(addressParts[0], 6, lineNumber);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }
                        break;
                    case "sw":
                        if (arguments.Length == 2)
                        {
                            validateRegister(arguments[0], lineNumber, false);
                            if (arguments[1].Last() != ')')
                            {
                                throw new Exception("Syntax error missing ')' on line " + lineNumber);
                            }
                            string[] addressParts = arguments[1].Split(new char[] {')', '('}, StringSplitOptions.RemoveEmptyEntries);
                            if (addressParts.Length != 2)
                            {
                                throw new Exception("Syntax error on second argument on line " + lineNumber);
                            }
                            validateRegister(addressParts[1], lineNumber, false);
                            validateImmediate(addressParts[0], 6, lineNumber);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }
                        break;
                    case "jr":
                        if (arguments.Length == 1)
                        {
                            validateRegister(arguments[0], lineNumber, false);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }                        
                        break;
                    case "j":
                        if (arguments.Length == 1)
                        {
                            validateImmediate(arguments[0], 12, lineNumber);
                        }
                        else
                        {
                            throw new Exception("Invalid number of arguments on line " + lineNumber);
                        }                        
                        break;

                    default:
                        throw new Exception("Instruction '" + instruction + "' not recognized on line " + lineNumber);
                }

                lineNumber++;
            }

        }

        private static void validateImmediate(string immediate, int size, int lineNumber)
        {
            int immediateNumber = 0;
            try
            {
                immediateNumber = Int32.Parse(immediate);
            }
            catch (Exception e)
            {
                if (!labelTable.ContainsKey(immediate))
                {
                    throw new Exception("Invalid immediate " + immediate + " on line " + lineNumber);
                }
            }

            if (immediateNumber < -1 * Math.Pow(2, size) || immediateNumber > Math.Pow(2, size) - 1) {
                throw new Exception("Invalid number " + immediate + "on line " + lineNumber);
            }
        }

        private static void validateRegister(string register, int lineNumber, bool writeToThisRegister)
        {
            if (register.First() != '$')
            {
                throw new Exception("Syntax error missing '$' on line " + lineNumber);
            }
            int registerNumber = 0;
            try
            {
                registerNumber = Int32.Parse(register.Substring(1));
            }
            catch (Exception e)
            {
                throw new Exception("Invalid register " + register + " on line " + lineNumber);
            }

            if (registerNumber < 0 || registerNumber > 7)
            {
                throw new Exception("Invalid register " + register + " on line " + lineNumber);
            }

            if (registerNumber == 0 && writeToThisRegister)
            {
                Console.WriteLine("Warning: Cannot write to register 0. Your instruction will have no effect. Line number: " + lineNumber);
            }
        }


        private static Dictionary<string, int> makeLabelTable(StreamReader reader)
        {
            Dictionary<string, int> labelTable = new Dictionary<string, int>();
            int lineNumber = 1;
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
            return labelTable;
        }
        private static string convertAndSignExtend(string part, int numBits, Dictionary<string, int> labelTable )
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

            opCode.Add("beq", "1100");
            opCode.Add("bne", "1101");
            opCode.Add("slt", "1110");

            opCode.Add("lw", "0010");
            opCode.Add("sw", "0011");
            
            return opCode;

        }

        private static void writeOutputFile(StreamReader reader, StreamWriter writer)
        {
            writer.WriteLine("DEPTH = 256;");
            writer.WriteLine("WIDTH = 16;");
            writer.WriteLine("ADDRESS_RADIX = DEC;");
            writer.WriteLine("DATA_RADIX = BIN;");
            writer.WriteLine("");
            writer.WriteLine("CONTENT");
            writer.WriteLine("\tBEGIN");
            writer.WriteLine("\t[0..255]\t:\t0000000000000000;");
            writer.WriteLine("\t0\t\t\t:\t0000000000000000;");


            Dictionary<string, string> opCodes = makeOpCodeDictionary();
            Dictionary<string, string> aluCodes = makeALUCodeDictionary();

            int lineNumber = 1;

            while (!reader.EndOfStream)
            {
                string line = reader.ReadLine();
                string[] parts = line.Split(new char[] { ',', ' ', '\t', ')', '(' }, StringSplitOptions.RemoveEmptyEntries);
                int startingIndex = parts[0].Last() == ':' ? 1 : 0;

                writer.Write("\t" + (lineNumber) + "\t\t\t:\t");
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
                        writer.Write(convertAndSignExtend(parts[startingIndex + 2], 3, labelTable));
                        writer.Write(convertAndSignExtend(parts[startingIndex + 3], 3, labelTable));
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 3, labelTable));
                        writer.Write(aluCodes[parts[startingIndex]]);
                        break;

                    case "addiu":
                    case "subiu":
                    case "addi":
                    case "subi":
                    case "beq":
                    case "bne":
                        writer.Write(convertAndSignExtend(parts[startingIndex + 2], 3, labelTable));
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 3, labelTable));
                        writer.Write(convertAndSignExtend(parts[startingIndex + 3], 6, labelTable));
                        break;
                    case "lw":
                    case "sw":
                        int immediate = Convert.ToInt32(parts[startingIndex + 2]) * 8; 
                        writer.Write(convertAndSignExtend(parts[startingIndex + 3], 3, labelTable));
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 3, labelTable));
                        writer.Write(convertAndSignExtend(immediate.ToString(), 6, labelTable));
                        break;
                    case "jr":
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 3, labelTable));
                        writer.Write(convertAndSignExtend("0", 9, labelTable));
                        break;
                    case "j":
                        writer.Write(convertAndSignExtend(parts[startingIndex + 1], 12, labelTable));
                        break;

                    default:
                        break;
                }

                writer.WriteLine(";");
                lineNumber++;
            }

            writer.WriteLine("END;");
        }
    }
}
