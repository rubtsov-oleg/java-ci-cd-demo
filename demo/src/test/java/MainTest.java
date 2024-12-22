import static org.junit.jupiter.api.Assertions.assertEquals;

import org.example.Main;
import org.junit.jupiter.api.Test;

public class MainTest {
    @Test
    void testAdd() {
        assertEquals(5, Main.add(2, 3));
    }
}
