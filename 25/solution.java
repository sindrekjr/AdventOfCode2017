import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class Turing {
    private static HashMap<Integer, Boolean> tape = new HashMap<>();
    private static String state = "a"; // Should probably use enum
    private static int pos = 0;

    public static void main(String[] args) {
        for(int i = 0; i < 12172063; i++) {
            if(tape.get(pos) == null)  tape.put(pos, false);
            switch (state) {
                case "a":
                    if(tape.get(pos)) {
                        tape.put(pos, false);
                        pos--;
                        state = "c";
                    } else {
                        tape.put(pos, true);
                        pos++;
                        state = "b";
                    }
                    break;
                case "b":
                    if(tape.get(pos)) state = "d";
                    else state = "a";
                    tape.put(pos, true);
                    pos--;
                    break;
                case "c":
                    if(tape.get(pos)) {
                        tape.put(pos, false);
                        state = "c";
                    } else {
                        tape.put(pos, true);
                        state = "d";
                    }
                    pos++;
                    break;
                case "d":
                    if(tape.get(pos)) {
                        tape.put(pos, false);
                        pos++;
                        state = "e";
                    } else {
                        tape.put(pos, false);
                        pos--;
                        state = "b";
                    }
                    break;
                case "e":
                    if(tape.get(pos)) {
                        tape.put(pos, true);
                        pos--;
                        state = "f";
                    } else {
                        tape.put(pos, true);
                        pos++;
                        state = "c";
                    }
                    break;
                case "f":
                    if(tape.get(pos)) {
                        tape.put(pos, true);
                        pos++;
                        state = "a";
                    } else {
                        tape.put(pos, true);
                        pos--;
                        state = "e";
                    }
                    break;
            }
        }
        System.out.print(Collections.frequency(new ArrayList<>(tape.values()), true));
    }
}
