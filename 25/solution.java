import java.util.Collections;
import java.util.HashMap;

public class Turing {
    private static HashMap<Integer, Boolean> tape = new HashMap<>();
    private static String state = "a";
    private static int pos = 0;

    public static void main(String[] args) {
        for(int i = 0; i < 12172063; i++) {
            if(tape.get(pos) == null)  tape.put(pos, false);
            boolean value = tape.get(pos);
            switch(state) {
                case "a":
                    if(value) {
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
                    if(value) state = "d";
                    else state = "a";
                    tape.put(pos, true);
                    pos--;
                    break;
                case "c":
                    if(value) {
                        tape.put(pos, false);
                        state = "c";
                    } else {
                        tape.put(pos, true);
                        state = "d";
                    }
                    pos++;
                    break;
                case "d":
                    tape.put(pos, false);
                    if(value) {
                        pos++;
                        state = "e";
                    } else {
                        pos--;
                        state = "b";
                    }
                    break;
                case "e":
                    tape.put(pos, true);
                    if(value) {
                        pos--;
                        state = "f";
                    } else {
                        pos++;
                        state = "c";
                    }
                    break;
                case "f":
                    tape.put(pos, true);
                    if(value) {
                        pos++;
                        state = "a";
                    } else {
                        pos--;
                        state = "e";
                    }
                    break;
            }
        }
        System.out.print(Collections.frequency((tape.values()), true));
    }
}
