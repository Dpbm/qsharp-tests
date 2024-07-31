namespace MeasuringTest {

    open Microsoft.Quantum.Measurement;


    @EntryPoint()
    operation main() : Unit {
        Message("Testing different measurements with multiple qubits!");

        use q = Qubit();
        let resultZ = MeasureManyTimes(MeasureZTest, 1000);
        let resultX = MeasureManyTimes(MeasureXTest, 1000);
        let resultY = MeasureManyTimes(MeasureYTest, 1000);
        Message($"Results for Z: {resultZ}");
        Message($"Results for X: {resultX}");
        Message($"Results for Y: {resultX}");

    }

    operation MeasureZTest() : Result {
        use q = Qubit();
        X(q);
        let result = MResetZ(q);
        return result;
    }

    operation MeasureXTest() : Result {
        use q = Qubit();
        X(q);
        let result = MResetX(q);
        return result;
    }

    operation MeasureYTest() : Result {
        use q = Qubit();
        X(q);
        let result = MResetY(q);
        return result;
    }

    operation MeasureManyTimes(measurement : (Unit => Result), shots : Int) : Int[] {
        mutable results = [0, size = 2];

        for i in 1..shots {
            let result = measurement();
            if (result == Zero) {
                set results w/= 0 <- results[0] + 1;
            } else {
                set results w/= 1 <- results[1] + 1;
            }

        }
        return results;
    }
}