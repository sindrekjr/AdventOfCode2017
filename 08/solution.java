import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

public class Solution {
	static Integer largest = 0, largestEver = 0;
	static ArrayList<String[]> commands = new ArrayList<>();
	static HashMap<String, Integer> registers = new HashMap<>();

	public static void main(String[] args) throws Exception {
		File file = new File(ClassLoader.getSystemResource("input").toURI());
		BufferedReader reader = new BufferedReader(new FileReader(file));

		String[] in = reader.readLine().split("\\s+");
		do {
			commands.add(in);
			if(!registers.containsKey(in[0])) registers.put(in[0], 0);
			try { in = reader.readLine().split("\\s+"); } catch(Exception e) { in = null; }
		} while(in != null);
		reader.close();

		ScriptEngine js = new ScriptEngineManager().getEngineByName("JavaScript");
		for(String[] c : commands) {
			if(js.eval(registers.get(c[4]).toString() + c[5] + c[6]).toString().equals("true")) {
				if(c[1].equals("dec")) registers.put(c[0], registers.get(c[0]) - Integer.valueOf(c[2]));
				else if(c[1].equals("inc")) registers.put(c[0], registers.get(c[0]) + Integer.valueOf(c[2]));

				for(Integer val : registers.values()) if(val > largestEver) largestEver = val;
			}
		}

		for(Integer val : registers.values()) if(val > largest) largest = val;

		System.out.println("Largest: " + largest + "\nLargest ever: " + largestEver);
	}
}
